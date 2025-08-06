package calculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            double first = Double.parseDouble(request.getParameter("first"));
            double second = Double.parseDouble(request.getParameter("second"));
            String operator = request.getParameter("operator");

            double result;

            switch (operator) {
                case "add":
                    result = first + second;
                    break;
                case "sub":
                    result = first - second;
                    break;
                case "mul":
                    result = first * second;
                    break;
                case "div":
                    if (second == 0) {
                        throw new ArithmeticException("Cannot divide by zero!");
                    }
                    result = first / second;
                    break;
                default:
                    throw new IllegalArgumentException("Invalid operator.");
            }

            request.setAttribute("first", first);
            request.setAttribute("second", second);
            request.setAttribute("operator", operator);
            request.setAttribute("result", result);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}