from TwitterStream import TwitterStream
import json
from dotenv import load_dotenv
from datetime import datetime
import boto3
import queue
import threading
import os

# main parameters, creds in .env
KEYWORDS = [
    "ml"
]
BUCKET = "twitter-stream"

load_dotenv()

def consumer():
    """
    Target for the listener thread. Listens for data in the queue to upload to S3.
    """

    tweet_list = []
    total_count = 0
    s3_client = boto3.client('s3')

    # thread loop...todo: use events to exit/pause
    while True:
        if not pipeline.empty():
            # if there's data in the queue, add to list
            label, data = pipeline.get()
            data_dict = json.loads(data)
            data_dict.update({"keywords": label})
            tweet_list.append(json.dumps(data_dict))
            total_count += 1

            print(f'QUEUE - GOT TWEET: {data_dict["data"]["id"]}')

            if total_count % 10 == 0:
                # batch every 10 tweets to upload to S3
                now = datetime.now()
                print("==> {0} tweets retrieved".format(str(total_count)))
                filename = f"tweets_{now.strftime('%Y%m%d%H%M%S')}.json"
                print(f"==> writing {str(len(tweet_list))} records to {filename}")
                tweet_file = open(filename, 'w')
                tweet_file.writelines(tweet_list)
                tweet_file.close()
                keywords = str(data_dict['keywords']).replace(' ','_')
                key = "{0}/{1}/{2}/{3}/{4}/{5}/{6}".format(keywords, str(now.year), 
                                                           str(now.month), str(now.day),
                                                           str(now.hour), str(now.minute), filename)
                print(f"==> uploading to {key}")
                s3_client.upload_file(filename, BUCKET, key)
                print(f"==> uploaded to {key}")
                tweet_list = []
                os.remove(filename)

def main():
    """
    Main thread for streaming tweets.
    """

    # the pipeline (queue) is shared between threads
    global pipeline

    # keyword-based rule for twitter streaming
    keywords = ' '.join(KEYWORDS)
    stream_rules = [
        {"value": f"{keywords} lang:en"}
    ]

    # create queue and consumer thread
    pipeline = queue.Queue()
    t = threading.Thread(target=consumer)

    # configure twitter stream
    ts = TwitterStream()
    rules = ts.get_rules()
    delete = ts.delete_all_rules(rules)
    set = ts.set_rules(delete, stream_rules)
    response = ts.get_stream(set)

    # start the consumer thread before we start the twitter stream
    t.start()

    for response_line in response.iter_lines():
        # start stream by iterating through the response (a generator)
        if response_line:
            # write each tweet to pipeline (the queue)
            json_response = json.loads(response_line)
            print(f'STREAM - RECEIVED TWEET: {json_response["data"]["id"]}')
            tweet = json.dumps(json_response, indent=4, sort_keys=True)
            pipeline.put((keywords, tweet))


if __name__ == "__main__":
    main()
