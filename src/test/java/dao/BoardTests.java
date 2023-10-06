package dao;

import com.example.mvc.model.BoardDAO;
import com.example.mvc.model.BoardDTO;
import org.junit.jupiter.api.Test;

public class BoardTests {
    @Test
    public void testBoardInsert() {
        for (int i = 0; i < 100; i++) {
            BoardDAO boardDAO = BoardDAO.getInstance();
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setMemberId("Test" + i);
            boardDTO.setSubject("제목" + i);
            boardDTO.setContent("내용" + i);
            boardDTO.setName("작성자" + i);
            boardDTO.setHit(0);
            boardDTO.setAddDate("2020-01-01" + i);
            boardDAO.insertBoard(boardDTO);
        }
    }

    @Test
    public void testUpdateBoard() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        BoardDTO boardDTO = boardDAO.getBoardByNum(1);
        System.out.println(boardDTO); // 수정전
        
        boardDTO.setName("철수");
        boardDTO.setSubject("제목1-2");
        boardDTO.setContent("내용1-2");
        boardDAO.updateBoard(boardDTO);
        System.out.println(boardDTO); // 수정후
    }

    @Test
    public void testDeleteBoard() {
        BoardDAO boardDAO = BoardDAO.getInstance();
        boardDAO.deleteBoard(1);
    }
}
