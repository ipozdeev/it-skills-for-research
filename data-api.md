# data api

## introduction

In addition to the functionality of downloading stuff from their website, some data vendors would provide a *data API*.

API stands for 'application programming interface'. Think about user interface (UI), which is anything that helps the end user get non-sophisticated access to sophisticated technology; API helps applications (=programs) to get access to server resources via HTTP. The latter part means that API requests are sent as familiar `http://` links &ndash; possibly even through your web browser.

Why does it work? First, note that whenever you follow an ordinary url such as [https://fred.stlouisfed.org/](https://fred.stlouisfed.org/), what you really do is send a request to a remote server, to which the server responds by sending you back some HTML code plus some data which your browser renders as a webpage for you to see. In the same way, if you follow a special url such as
[https://api.stlouisfed.org/fred/series/observations?series_id=DGS10](https://api.stlouisfed.org/fred/series/observations?series_id=DGS10)
the server might respond with giving you data from its database. It is the task of the server developer to write an API which people can use to access the data behind the curtains.

If for some reason you need the freshest data possible, or would like to automate data upstream without necessity to click on buttons, the API comes in handy.

In what follows we will get familiar with the [FRED API](https://fred.stlouisfed.org/) and code our own wrapper for it to be able to just
```python
data = get_fred_data("DGS10")
```
every time we need the latest US 10-year Treasury yield.

## before we start
[postman]() is an app that can be used to peek into api requests


## terminology
*   root url
*   endpoint
*   request
*   response
*   parameters
*   authorization
