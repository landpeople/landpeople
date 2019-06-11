package happy.land.people.dto;

public class SketchPagingDto {
		
		private int pageListSize; 		// 페이지 목록의 사이즈 (ex) 10개로 정하면 <1~10> 5개로 정하면 <1~5>) ) 	
		private int nowPageNo;    		// 현재 페이지 번호
		private int totalBoardSize;     // 총 게시글 개수
		private int pageBoardSize;      // 페이지당 보여줄 게시글 크기 (ex)5로 정하면 1페이지당 게시글 5개를 보여줌)
		
		private int firstPageNo; 		// 처음 페이지 번호  (만약 페이지 개수가 총 42개라면 firstPageNo은 1)
		private int lastPageNo; 		// 마지막 페이지 번호  (만약 페이지 개수가 총 42개라면 lastPageNo은 42)
		
		private int prevPageNo; 		// 현재 페이지에서 이전 페이지 번호
		private int nextPageNo; 		// 현재 페이지에서 다음 페이지 번호
		
		private int startPageNo; 		// 현재 페이지 목록들(ex)<11~20>)에서 시작 페이지 번호 
		private int endPageNo;   		// 현재 페이지 목록들(ex)<11~20>)에서 맨끝 페이지 번호
		
		private int firstBoardNo;		// 현재 페이지에서 시작 게시글 번호
		private int endBoardNo;			// 현재 페이지에서 마지막 게시글 번호
		
		
		public SketchPagingDto() {
			
		}	
		
		public SketchPagingDto(int pageListSize, int nowPageNo, int totalBoardSize, int pageBoardSize) {		
			this.pageListSize = pageListSize;
			this.nowPageNo = nowPageNo;		
			this.pageBoardSize = pageBoardSize;
			
			setTotalBoardSize(totalBoardSize);
		}

		public SketchPagingDto(int nowPageNo, int pageBoardSize) {
			super();
			this.nowPageNo = nowPageNo;
			this.pageBoardSize = pageBoardSize;
		}

		public int getPageListSize() {
			return pageListSize;
		}
		public void setPageListSize(int pageListSize) {
			this.pageListSize = pageListSize;
		}
		public int getNowPageNo() {
			return nowPageNo;
		}
		public void setNowPageNo(int nowPageNo) {
			this.nowPageNo = nowPageNo;
		}
		public int getTotalBoardSize() {
			return totalBoardSize;
		}
		public void setTotalBoardSize(int totalBoardSize) {
			this.totalBoardSize = totalBoardSize;
			makePage();
		}
		public int getPageBoardSize() {
			return pageBoardSize;
		}
		public void setPageBoardSize(int pageBoardSize) {
			this.pageBoardSize = pageBoardSize;
		}
		public int getFirstPageNo() {
			return firstPageNo;
		}
		public void setFirstPageNo(int firstPageNo) {
			this.firstPageNo = firstPageNo;
		}
		public int getLastPageNo() {
			return lastPageNo;
		}
		public void setLastPageNo(int lastPageNo) {
			this.lastPageNo = lastPageNo;
		}
		public int getPrevPageNo() {
			return prevPageNo;
		}
		public void setPrevPageNo(int prevPageNo) {
			this.prevPageNo = prevPageNo;
		}
		public int getNextPageNo() {
			return nextPageNo;
		}
		public void setNextPageNo(int nextPageNo) {
			this.nextPageNo = nextPageNo;
		}
		public int getStartPageNo() {
			return startPageNo;
		}
		public void setStartPageNo(int startPageNo) {		
			this.startPageNo = startPageNo;
		}
		public int getEndPageNo() {
			return endPageNo;
		}
		public void setEndPageNo(int endPageNo) {		
			this.endPageNo = endPageNo;
		}
		public int getFirstBoardNo() {
			return firstBoardNo;
		}
		public void setFirstBoardNo(int firstBoardNo) {
			this.firstBoardNo = firstBoardNo;
		}
		public int getEndBoardNo() {
			return endBoardNo;
		}
		public void setEndBoardNo(int endBoardNo) {
			this.endBoardNo = endBoardNo;
		}
		
		
		private void makePage() {
			if(totalBoardSize == 0) {
				return;
			}
			if(nowPageNo == 0) {
				setNowPageNo(1);
			}
			if(pageListSize == 0) {
				setPageListSize(9);
			}
			if(pageBoardSize == 0) {
				setPageBoardSize(9);
			}
			
			int finalPage = (totalBoardSize+(pageBoardSize-1))/pageBoardSize; // 마지막 페이지 번호
			
			// 현재 페이지가 마지막 페이지보다 클경우 현재 페이지를 마지막 페이지로 설정
			if(nowPageNo > finalPage) {
				setNowPageNo(finalPage);			
			}
			
			boolean isPageNowFirst = (nowPageNo == 1)? true:false; 			// 현재 페이지가 맨처음인지
			boolean isPageNowLast = (nowPageNo == finalPage)? true:false;	// 현재 페이지가 마지막인지
			
			// 현재 페이지 번호에서 보여줄 페이지 리스트 번호 (ex) 현재 페이지가 8이라면 <6~10>)
			int startPage = ((nowPageNo-1)/pageListSize)*pageListSize+1;
			int endPage = startPage+(pageListSize-1);
			
			// 현재 페이지 번호에서 보여줄 게시글 번호들 (ex) 현재 페이지가 8이라면 71~80개의 게시글)
			int startBoard = nowPageNo*pageBoardSize-(pageBoardSize-1);
			int endBoard = nowPageNo*pageBoardSize;
			
			// endPage가 마지막 페이지를 넘을수 없도록
			if(endPage > finalPage) {
				endPage = finalPage;
			}		
			// 현재 페이지가 첫번째페이지라면 
			if(isPageNowFirst) {
				setPrevPageNo(1);
			}else {
				setPrevPageNo((nowPageNo-1)<0? 1:(nowPageNo-1));
			}
			// 페이지 스타트,엔드 번호
			setStartPageNo(startPage);
			setEndPageNo(endPage);
			// 게시글 스타트,엔드 번호 
			setFirstBoardNo(startBoard);
			setEndBoardNo(endBoard);
			// 현재 페이지가 마지막페이지라면
			if(isPageNowLast) {
				setNextPageNo(finalPage);
			}else {
				setNextPageNo((nowPageNo+1)>finalPage? finalPage:(nowPageNo+1));			
			}
			
			setLastPageNo(finalPage);
		}

		@Override
		public String toString() {
			return "SketchPagingDto [pageListSize=" + pageListSize + ", nowPageNo=" + nowPageNo + ", totalBoardSize="
					+ totalBoardSize + ", pageBoardSize=" + pageBoardSize + ", firstPageNo=" + firstPageNo
					+ ", lastPageNo=" + lastPageNo + ", prevPageNo=" + prevPageNo + ", nextPageNo=" + nextPageNo
					+ ", startPageNo=" + startPageNo + ", endPageNo=" + endPageNo + ", firstBoardNo=" + firstBoardNo
					+ ", endBoardNo=" + endBoardNo + "]";
		}	
}
