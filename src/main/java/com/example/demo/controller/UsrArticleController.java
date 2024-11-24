package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.Board;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Rq;
import com.example.demo.service.ArticleService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;
	private ReplyService replyService;
	
	public UsrArticleController(ArticleService articleService, ReplyService replyService) {
		this.articleService = articleService;
		this.replyService = replyService;
	}
	
	@GetMapping("/usr/article/write")
	public String write() {
		return "usr/article/write";
	}
	
	@PostMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int boardId, String title, String body) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);
		
		int id = articleService.getLastInsertId();
		
		return Util.jsReturn(String.format("%d번 게시물을 작성했습니다", id), String.format("detail?id=%d", id));
	}

	@GetMapping("/usr/article/list")
	public String showList(Model model, int boardId, @RequestParam(defaultValue = "1") int cPage) {
		Board board = articleService.getBoardById(boardId);

		int limitFrom = (cPage - 1) * 10;
		
		List<Article> articles = articleService.getArticles(boardId, limitFrom);
		int articlesCnt = articleService.getArticlesCnt(boardId);
		
		int totalPagesCnt = (int) Math.ceil((double) articlesCnt / 10);
		
		int from = ((cPage - 1) / 10) * 10 + 1;
		int end = (((cPage - 1) / 10) + 1) * 10;
		
		if (end > totalPagesCnt) {
			end = totalPagesCnt;
		}
		
		model.addAttribute("board", board);
		model.addAttribute("articles", articles);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("totalPagesCnt", totalPagesCnt);
		model.addAttribute("from", from);
		model.addAttribute("end", end);
		model.addAttribute("cPage", cPage);
		
		return "usr/article/list";
	}
	
	@GetMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.getArticleById(id);
		List<Reply> replies = replyService.getReplies("article", id);
		
		model.addAttribute("article", article);
		model.addAttribute("replies", replies);
		
		return "usr/article/detail";
	}
}
//1