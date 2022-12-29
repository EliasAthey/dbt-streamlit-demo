import requests
import os
import json
from dotenv import load_dotenv

class TwitterStream:
    """
    Object for configuring and using th FilteredStream Twitter V2 API.
    Copied and modified from https://github.com/twitterdev/Twitter-API-v2-sample-code/blob/main/Filtered-Stream/filtered_stream.py
    """

    def __init__(self):
        pass

    def bearer_oauth(self, r):
        """
        Method required by bearer token authentication.
        """

        bearer_token = os.environ.get("TWITTER_BEARER_TOKEN")
        r.headers["Authorization"] = f"Bearer {bearer_token}"
        r.headers["User-Agent"] = "v2FilteredStreamPython"
        return r


    def get_rules(self):
        """
        Gets the current rules applied to the stream
        """
        
        response = requests.get(
            "https://api.twitter.com/2/tweets/search/stream/rules", auth=self.bearer_oauth
        )
        if response.status_code != 200:
            raise Exception(
                "Cannot get rules (HTTP {}): {}".format(response.status_code, response.text)
            )
        print(f'GETTING RULES:\n{json.dumps(response.json())}')
        return response.json()


    def delete_all_rules(self, rules):
        """
        Removes the provided rules formthe stream
        """

        if rules is None or "data" not in rules:
            return None

        ids = list(map(lambda rule: rule["id"], rules["data"]))
        payload = {"delete": {"ids": ids}}
        response = requests.post(
            "https://api.twitter.com/2/tweets/search/stream/rules",
            auth=self.bearer_oauth,
            json=payload
        )
        if response.status_code != 200:
            raise Exception(
                "Cannot delete rules (HTTP {}): {}".format(
                    response.status_code, response.text
                )
            )
        print(f'DELETING RULES:\n{json.dumps(response.json())}')


    def set_rules(self, delete, rules):
        """
        Applies rules to the stream
        """

        payload = {"add": rules}
        response = requests.post(
            "https://api.twitter.com/2/tweets/search/stream/rules",
            auth=self.bearer_oauth,
            json=payload,
        )
        if response.status_code != 201:
            raise Exception(
                "Cannot add rules (HTTP {}): {}".format(response.status_code, response.text)
            )
        print(f'ADDING RULES:\n{json.dumps(response.json())}')


    def get_stream(self, set):
        tweet_fields = [
            "id",
            "text",
            "author_id",
            "in_reply_to_user_id",
            "geo",
            "conversation_id",
            "created_at",
            "lang",
            "public_metrics",
            "referenced_tweets",
            "reply_settings",
            "source"]
        author_fields = [
            "id",
            "name",
            "username",
            "created_at",
            "description",
            "public_metrics",
            "verified"]
        place_fields = [
            "id",
            "full_name",
            "place_type"]
        endpoint = "https://api.twitter.com/2/tweets/search/stream" +\
            f"?tweet.fields={','.join(tweet_fields)}" +\
            f"&expansions=author_id,geo.place_id" +\
            f"&user.fields={','.join(author_fields)}" +\
            f"&place.fields={','.join(place_fields)}"
        
        response = requests.get(
            endpoint, auth=self.bearer_oauth, stream=True,
        )
        print(response.status_code)
        if response.status_code != 200:
            raise Exception(
                "Cannot get stream (HTTP {}): {}".format(
                    response.status_code, response.text
                )
            )
        # return response (stream)
        return response
        