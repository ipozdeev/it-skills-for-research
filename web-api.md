# web api

<!-- TOC -->

- [web api](#web-api)
  - [introduction](#introduction)
  - [before we start](#before-we-start)
  - [terminology](#terminology)
  - [implementation](#implementation)
    - [stating a request](#stating-a-request)
    - [sending the request](#sending-the-request)
    - [parsing the response](#parsing-the-response)
  - [data limits](#data-limits)
  - [wrappers](#wrappers)
  - [exercises](#exercises)

<!-- /TOC -->

## introduction

In addition to the functionality of bulk downloading data, some websites would provide a *web data API*.

API stands for 'application programming interface'. Think about user interface (UI), which is an abstraction that helps a user get easy access to sophisticated technology; API is a similar abstraction that helps applications (=programs) to get access to server resources. Here, we will cover HTTP-based APIs, meaning that requests are sent as familiar `http://` links &ndash; and hence can be handled even through your web browser.

Why does it work? First, note that whenever you click on an ordinary URL link such as [https://fred.stlouisfed.org/](https://fred.stlouisfed.org/), what you really do is send a request to a remote server, to which the server responds by sending you back some HTML code and data which your browser renders as a webpage for you to see. In the same way, if you follow a special link such as
[https://api.stlouisfed.org/fred/series/observations?series_id=DGS10](https://api.stlouisfed.org/fred/series/observations?series_id=DGS10)
the server might respond by sending you data from its database. It is the task of the server developer to write an API which can be used to access the data behind the curtains.

API comes in handy for those who would frequently need the freshest data possible or would like to automate data upstream without necessity to click on buttons.

In what follows we will get familiar with the [Kraken API](https://docs.kraken.com/rest/) and code our own wrapper for it to be able to simply run
```python
data = get_trades("XBT", since="2020-01-15")
```
every time we need Bitcoin trades details.

## before we start
[postman]() is an app that can be used to peek into API requests and is a good choice for educational purposes.


## terminology
*   **request**: what you send to the server; set of instructions in the form of a link, e.g. `https://api.kraken.com/0/public/Trades?pair=XBTUSD` which tells the server what you want to retrieve;
*   **response**: what the server sends back; most frequently a dictionary-like JSON object containing the error message and the payload;
*   **error code**: a brief message about how the request was processed. Some examples for HTTP-based APIs can be found [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status). The two most popular ones are error code `200` meaning no error and `400` meaning bad request (usually due to typos or misspecification of parameters);
*   **root URL**: the address that all requests of an API will start with. In analogy with SQL, the root URL is a database. For instance, `https://api.kraken.com/0/public` is the root URL to the public data database containing OHLC data, recent trades etc. as _endpoints_;
*   **endpoint**: defined location of a particular dataset. In analogy with SQL, an endpoint is a table within a database. For instance, relative to the root, `/OHLC` identifies the point of access to the OHLC data;
*   **parameters**: specifications to a request. In SQL, these could be the `SELECT...` and `WHERE...` part of the query. Parameters are separated from the endpoint with the question mark sign `?`and from each other with the ampersand `&`. Some parameters are required: omitting them would lead to a bad request, &ndash; while others are optional.
*   **authorization**: some requests cannot be fulfilled without authorization. For instance, if you would like to place trade orders from your account using an API, you must prove your identity first. This can be done via several methods which we won't discuss here.


## implementation
Jupyter notebook `api-example.ipynb` in folder **jupyter** contains clickable Python code for the following.

### stating a request
As stipulated in the API documentation, the `Trades` endpoint gives access to 1000 trades involving a given currency since a given date. Navigating to the [Trades section](https://docs.kraken.com/rest/#operation/getRecentTrades) of the API documentation, we see what must be included in the request to retrieve this data and which elements a successful response would contain.

Again, the API request is just a text link sent to the Kraken server; we construct it from the root URL `https://api.kraken.com/0/public`, the endpoint `/Trades` the and parameters `pair` and `since`. To retrieve Bitcoin Cash data since 2020/01/25 15:15:00
we first note that the pair must be specified as `XXXYYY` and that parameter `since` must be a [UNIX time](https://en.wikipedia.org/wiki/Unix_time). Hence, the link is constructed as `pair=BCHUSD&since=1579961700`.

### sending the request
Sending the request can be done by following the link in your web browser (try it!) or with Python's `requests` library, or any other similar library in your software of choice. The response generated by the server takes the form described in the API documentation and contains the error message (hopefully code 200) and the data hidden in JSON notation under `["result"]["BCHUSD"]`.

### parsing the response
The data returned by the server tends to come in a format not immediately suitable for processing, e.g. as text or a JSON object. The final task is to parse it.


## data limits
Many data vendors impose a limit on how much data you can download through their API. As you have seen already, sometimes it's the number of data points contained in the response's payload that is subject to the limit; quite frequently it's also the number of API calls per unit of time. In the latter case some idle time must be spent between subsequent API requests:
```python
import time

...  # one request-response iteration
time.sleep(2)  # 2 seconds of idleness
```
Together, the limits imply that additional coding &ndash; and patience &ndash; is needed to download large datasets.


## wrappers
As much of the above can be easily coded up and distributed, chances are high that there exist a Python, R etc wrappers for the API of your interest, written either by the data provider (the case of [quandl](https://data.nasdaq.com/tools/python)), or by a third party. Google it! Sometimes not an implementation but helpful tips are available, as is the case with [IMF](https://www.bd-econ.com/imfapi1.html).


## exercises
The first part is about the [Binance API](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md):
*   What is the root URL?
*   What is the endpoint to retrieve klines (open-high-low-close data) for a specific cryptocurrency?
*   Specify a request string to retrieve 75 observations of klines data for BTCUSDT since 2021-06-15.
*   Write a function (in Python, R or Julia) that retrieves 75 observations of klines data for a generic currency pair since a generic date. The function should take the currency pair and start date as input parameters.

The rest is about the [FRED API](https://fred.stlouisfed.org/docs/api):
*   Read how authentication with API keys works. Create an account and obtain your own key.
*   What is the root URL?
*   What is the endpoint to retrieve time series observations?
*   Construct a query string to retrieve the series of the monthly unemployment rate (seasonally adjusted) since 2020-01. Use the fake API key `abc123` in the query string.
