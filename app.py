import streamlit as st
import numpy as np

st.write('# Hello! Welcome to my app')
usr_val = st.slider('Slide Me!',0,10)
st.write(f'## Your Value: {usr_val}')

data = np.random.random([usr_val, 10])
st.bar_chart(data)