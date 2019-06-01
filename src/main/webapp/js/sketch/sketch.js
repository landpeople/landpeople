/**
 * index.jsp 스케치북
 */
function sketchSelectTheme(theme){
	alert(theme);
	var themeType= theme;
	
	location.href="./sketchBookTheme.do?type="+themeType;
}