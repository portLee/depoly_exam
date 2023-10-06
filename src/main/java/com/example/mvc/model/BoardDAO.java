package com.example.mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.example.mvc.database.DBConnection;

public class BoardDAO {
	private static BoardDAO instance;
	
	private BoardDAO() {
	}
	
	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	public int getListCount(String items, String text) {
		/*Board 테이블의 전체 레코드 개수 반환 */
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		int cnt = 0;

		String sql;
		if(items == null || text == null) { //검색어가 없는 경우
			sql = "select count(*) from board";
		}
		else {
			sql = "select count(*) from board where " + items + " Like '%" + text + "%'";
		}

		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) { //데이터가 있는 경우
				cnt = resultSet.getInt(1);
			}
		}catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			try {
				if(resultSet != null)
					resultSet.close();
				if(preparedStatement != null)
					preparedStatement.close();
				if(connection != null)
					connection.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return cnt;
	}


	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		// board 테이블의 레코드 가져오기
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		int start = (page - 1) * limit;
		String sql;
		if (items == null || text == null) { // 검색어가 없는 경우
			sql = "select * from board order by num desc";
		}
		else {
			sql = "select * from board where " + items + " like '%" + text + "%' order by num desc";
		}
		sql += " limit " + start + ", " + limit;
		
		ArrayList<BoardDTO> list = new ArrayList<>();
		
		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while (resultSet.next()) {
				BoardDTO board = new BoardDTO();
				board.setNum(resultSet.getInt("num"));
				board.setMemberId(resultSet.getString("memberId"));
				board.setName(resultSet.getString("name"));
				board.setSubject(resultSet.getString("subject"));
				board.setContent(resultSet.getString("content"));
				board.setHit(resultSet.getInt("hit"));
				board.setIp(resultSet.getString("ip"));
				board.setAddDate(resultSet.getString("addDate"));
				list.add(board);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		
		return null;
	}

	public void insertBoard(BoardDTO board) {
		// board 테이블에 새로운 글 삽입하기
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "insert into board (memberId, name, subject, content, hit, ip, ADDDATE)" +
					"values (?, ?, ?, ?, ?, ?, now())";

			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, board.getMemberId());
			preparedStatement.setString(2, board.getName());
			preparedStatement.setString(3,board.getSubject());
			preparedStatement.setString(4, board.getContent());
			preparedStatement.setInt(5, board.getHit());
			preparedStatement.setString(6, board.getIp());
			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	private void updateHit(int num) {
		// 선택된 글의 조회수 증가하기
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = DBConnection.getConnection();

			String sql = "update board set hit = hit + 1 where num = ?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, num);
			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}
	
	public BoardDTO getBoardByNum(int num) {
		// 선택한 글 상세 내용 가져오기
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		BoardDTO board = null;

		updateHit(num);
		String sql = "select * from board where num = ?";
		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, num);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				board = new BoardDTO();
				board.setNum(resultSet.getInt("num"));
				board.setMemberId(resultSet.getString("memberId"));
				board.setName(resultSet.getString("name"));
				board.setSubject(resultSet.getString("subject"));
				board.setContent(resultSet.getString("content"));
				board.setAddDate(resultSet.getString("addDate"));
				board.setHit(resultSet.getInt("hit"));
				board.setIp(resultSet.getString("ip"));
			}
			return board;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	public void updateBoard(BoardDTO board) {
		// 선택된 글 내용 수정하기
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			String sql = "update board set name = ?, subject = ?, content = ? where num = ?";

			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);

			preparedStatement.setString(1, board.getName());
			preparedStatement.setString(2, board.getSubject());
			preparedStatement.setString(3, board.getContent());
			preparedStatement.setInt(4, board.getNum());

			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw  new RuntimeException(ex.getMessage());
			}
		}
	}

	public void deleteBoard(int num) {
		// 선택된 글 삭제하기
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String sql = "delete from board where num = ?";

		try {
			connection = DBConnection.getConnection();
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, num);
			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			try {
				if (preparedStatement != null) {
					preparedStatement.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (Exception ex) {
				throw  new RuntimeException(ex.getMessage());
			}
		}
	}
}
