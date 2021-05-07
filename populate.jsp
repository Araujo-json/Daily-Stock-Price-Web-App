<%--
  Created by IntelliJ IDEA.
  User: Jeison
  Date: 4/17/2021
  Time: 1:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String searchIn = request.getParameter("searchKey");
    try {
        String db = "jdbc:mysql://localhost:3306/stocklist", password = "",
                user = "root", dbTable = "stocklist_table";

        Class.forName("com.mysql.cj.jdbc.Driver");
        // 2 are for the colleges
        Connection connection = DriverManager.getConnection(db, user, password);
        String sqlSelect = " SELECT * FROM " + dbTable
                + " WHERE match (`Exchange`, `Symbol`, `Name`, `LastSale`, `ADR TSO`, `IPOyear`, `Sector`, `Industry`, `Summary Quote`) " +
                " against('+" + searchIn + "' in boolean mode) " /*+
                "Symbol like '" + searchIn + "%' "
                + " or name like '" + searchIn + "%' "*/;
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sqlSelect);

        String exchange,symbol,name,lastSale,ADRTSO,IPOyear,sector,industry,summary_quote, stocks = "";

        Double marketCap;
        if(rs != null)
        {
            out.println("<select id='stockList' onchange=\"displayInfo()\">");
            out.println("<option value=' '>—Select one—</option>");

            while (rs.next()) {

                symbol  = rs.getString("Symbol");
                name = rs.getString("Name");

                out.println("<option value='" + symbol + "'>" + name + "  —  " + symbol + "</option>");
            }
            out.print("<select>");
        }
        else
            out.println("No company found on the exchange");
    }
    catch (SQLException e){}

%>
