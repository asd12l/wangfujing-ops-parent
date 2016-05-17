<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jquery鼠标悬停横向时间轴代码 - 魔客吧</title>

<link href="css/timeline.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/jquery1.10.2.js"></script>
<script type="text/javascript">
$(function(){
	
	$('.shiji').slideDown(600);
		
	//首页大事记
	/*$('.course_nr2 li').hover(function(){
		$(this).find('.shiji').slideDown(600);
	},function(){
		$(this).find('.shiji').slideUp(400);
	});*/
	
});
</script>

</head>

<body>

<div class="clearfix course_nr">
	<ul class="course_nr2">
		<li>
			2015/09/14
			<div class="shiji">
				<h1>2000￥</h1>
				<p>2015/09/14</p>
			</div>
		</li>
		<li>
			2015/09/18
			<div class="shiji">
				<h1>1800￥</h1>
				<p>2015/09/18</p>
			</div>
		</li>
		<li>
			2015/09/18
			<div class="shiji">
				<h1>2000￥</h1>
				<p>2015/09/18</p>
			</div>
		</li>		
	</ul>
</div>


</body>
</html>
