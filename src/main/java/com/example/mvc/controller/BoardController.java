package com.example.mvc.controller;

import com.example.mvc.service.BoardService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"*.do"})
public class BoardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BoardService boardService = BoardService.getInstance();
        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());
        System.out.println("command : " + command); // 파일경로 이름에서 불러옴.

        resp.setContentType("text/html; charset=utf-8");
        req.setCharacterEncoding("utf-8");

        switch (command) {
            case "/boardController/boardList.do" -> { // 등록된 글 목록 페이지 출력하기
                boardService.requestBoardList(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/list.jsp");
                requestDispatcher.forward(req, resp);
            }
            case "/boardController/boardAddForm.do" -> { // 글 등록 폼 출력하기
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/addForm.jsp");
                requestDispatcher.forward(req, resp);
            }
            case "/boardController/boardAddAction.do" -> { // 새로운 글 등록하기
                boardService.addBoard(req);
                resp.sendRedirect("./boardList.do");
            }
            case "/boardController/boardView.do" -> { // 글 상세 페이지 가져오기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/view.jsp");
                requestDispatcher.forward(req, resp);
            }
            case "/boardController/boardModifyForm.do" -> { // 글 수정 폼 출력하기
                boardService.getBoardView(req);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("../board/modifyForm.jsp");
                requestDispatcher.forward(req, resp);
            }
            case "/boardController/boardModifyAction.do" -> { // 글 수정하기
                boardService.modifyBoard(req);
                resp.sendRedirect("./boardList.do");
            }
            case "/boardController/boardRemoveAction.do" -> { // 글 삭제하기
                boardService.removeBoard(req);
                resp.sendRedirect("./boardList.do");
            }
        }
    }
}
