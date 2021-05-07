<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link href="stylesheet.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%--    <script src="index.js"></script>--%>
    <script>

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
        }
        function runJQuery()
        {
            const inputSearch = $("#searchTxtBx").val();

            if (inputSearch !== "")
            {
                $.ajax({
                    url: "populate.jsp" ,
                    data: "searchKey=" + inputSearch,
                    success: function (serverData) {
                        $("#showInfo").html(serverData);
                    }
                });
            }
            else
            {
                //cleaning up the placeholder
                $("#showInfo").empty();
                $("#m").empty();
            }
        }
        function displayInfo()
        {
            // console.log(convert());
            let KEYS = ["FK0WU9SE74OXJG5B", "5YX0HN8E4V6YAWV7", "LC34BKSTCTIOVOYG", "3US1Q9KNV3JK1BJS",
                "KW8TDPI0U3IBKWUP", "5B3JTCTINRXA5ZCP"];
            const KEY = KEYS[Math.floor(Math.random() * KEYS.length)];
            const stock_symb = $("#stockList").val();
            let url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=" + stock_symb + "&interval=1min&apikey="+ KEY;
            // check json data (inspect console)
            console.log(url);
            let ajax2 = $.ajax({
                url: url,
                dataType: 'json',
                contentType: "application/json",
                success: function(data){
                    const symbol = data['Meta Data']['2. Symbol'];
                    const lastRefreshed = data['Meta Data']['3. Last Refreshed'].substring(0,10);

                    const open = data['Time Series (Daily)'][lastRefreshed]['1. open']
                    const high = data['Time Series (Daily)'][lastRefreshed]['2. high']
                    const low = data['Time Series (Daily)'][lastRefreshed]['3. low']
                    const close = data['Time Series (Daily)'][lastRefreshed]['4. close']
                    const close_adj = data['Time Series (Daily)'][lastRefreshed]['5. adjusted close']
                    const volume = data['Time Series (Daily)'][lastRefreshed]['6. volume']
                    const dividend = data['Time Series (Daily)'][lastRefreshed]['7. dividend amount']
                    const split_coefficient = data['Time Series (Daily)'][lastRefreshed]['8. split coefficient']

                    $("#m").html
                    (
                        "                <table>" +
                        "                    <tr>" +
                        "                        <th>Open</th>" +
                        "                        <th>High</th>" +
                        "                        <th>Low</th>" +
                        "                        <th>Close</th>" +
                        "                    </tr>" +
                        "                    <tr>" +
                        "                        <td>" + numberWithCommas(open) + "</td>" +
                        "                        <td>" + numberWithCommas(high) + "</td>" +
                        "                        <td>" + numberWithCommas(low) + "</td>" +
                        "                        <td>" + numberWithCommas(close) + "</td>" +
                        "                    </tr>" +
                        "                    <tr>" +
                        "                        <th>Close Adjusted</th>" +
                        "                        <th>Volume</th>" +
                        "                        <th>Dividend amount</th>" +
                        "                        <th>Split coefficient</th>" +
                        "                    </tr>" +
                        "                    <tr>" +
                        "                        <td>" + numberWithCommas(close_adj) + "</td>" +
                        "                        <td>" + numberWithCommas(volume) + "</td>" +
                        "                        <td>" + numberWithCommas(dividend) + "</td>" +
                        "                        <td>" + numberWithCommas(split_coefficient) + "</td>" +
                        "                    </tr>" +
                        "                </table>"
                    );
                }
            });
        }
    </script>
</head>
<body>
<div id="main">
    <div>
        <h1>Company's Financial Stock</h1>
        Search: <input type="text" size="60" id="searchTxtBx" name="searchTxtBx" onkeyup="runJQuery();" autofocus>
        <br>
        <div id="showInfo"></div>
        <p></p>
        <div id="m"></div>
    </div>

</div>
</body>
</html>

<%--
Real-time Stock Price Web App

Create a Web app that displays the price of a company's financial stock.
You are given a csv file that stores companies' information.
These companies are listed on the three major stock exchanges:
Nasdaq, Amex, and NYE. User can search a company and the app will extract the company's symbol
from the csv and feed it into a free stock price service provider, such as Alpha Advantage,

--%>