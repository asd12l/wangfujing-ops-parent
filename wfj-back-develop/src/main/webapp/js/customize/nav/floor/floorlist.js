/**
 * 楼层JS
 */
var zTreeFloor, rMenuFloor;
//楼层树选中获取ID
var pageLayoutSid="";

//楼层树右键获取ID
var fNodeId="";

//加载楼层详情数据
var floor_title="";
var floor_seq="";
var floor_style="";
var floor_type="";
var floor_flag="";
var floor_content="";
var floor_enTitle="";
var floor_channelLink = "";
//楼层树节点 类型 0楼层 1商品块 2品牌块 3引导链接块
var floorType="";

	$(function(){
		/**
		 * 绑定Tab楼层文字点击事件
		 */
		$("#floor_page_change").click(function(){
			initStyleList();
		});
		
		/**
		 * valid验证
		 */
		validAddForm();
		validEditForm();
		validformAddLink();
		validformEditLink();
		validSaveDivForm();
		validEditDivForm();
		
		//添加块.块组时显示不同的选项
		$("input").click(function(){
			//如果选块,显示三种块类型
			if($("#add_divType_0").is(':checked')){
				$("#add_floorType").hide();
			}else if($("#add_divType_1").is(':checked')){
				$("#add_floorType").show();
			}
			//如果是商品块,显示样式列表
			if($(".add_divType_2").is(':checked')){
				$(".adddiv_selectlist").show();
			}else{
				$(".adddiv_selectlist").hide();
			}
		});
	});
	
	/**
	 * 根据floorType添加不同资源
	 */
	function addResources(){
		$("#pageLayoutSid_").val(fNodeId);
		if(floorType==1){
			addPro();
		}else if(floorType==2){
			addFloorBrand();
		}else if(floorType==3){
			addLink();
		}
		rMenuFloor.css({"visibility" : "hidden"});
	};
	/**
	 * 楼层块重命名
	 */
	function renameFloorDiv(){
		editFloorDiv(fNodeId,floor_type);
		rMenuFloor.css({"visibility" : "hidden"});
	};
	/**
	 * 初始化添加楼层时styleList列表
	 */
	function initStyleList(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/stylelist/queryStyleList",
			dataType : "json",
			data : {
				"_site_id_param":siteSid,
				"type":0
			},
			async : false, 
			success : function(response) {
				var styleList = $(".style_list");
				var result = response.list;
				styleList.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.name + "'>"
							+ ele.desc + "</option>");
					option.appendTo(styleList);
				}
			}
		});
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/stylelist/queryStyleList",
			dataType : "json",
			data : {
				"_site_id_param":siteSid,
				"type":2
			},
			async : false, 
			success : function(response) {
				var styleList = $(".pro_style_list");
				var result = response.list;
				styleList.html("");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.name + "'>"
							+ ele.desc + "</option>");
					option.appendTo(styleList);
				}
			}
		});
	};
	
	/**
	 * 初始化楼层树
	 */
	function initFloorTree() {
		nodeId="";
		$.fn.zTree.init($("#floorTree"), {
			async: {
				enable : true,
				url : __ctxPath + "/web/getAllFloorResources?sid=" + channelId,
				dataType : "json",
				autoParam : ["id"],// 请求下一级参数ID
				dataFilter : filter
			},
			view: {
				showIcon: true,
				dblClickExpand: false,
				fontCss: setFontCss
			},
			callback: {
				onClick: zTreeFloorOnClick,
				onRightClick: FloorOnRightClick
			}
		});
		zTreeFloor = $.fn.zTree.getZTreeObj("floorTree");
		rMenuFloor = $("#rMenuFloor");
	};
	
	/**
	 * 楼层Tree单击事件
	 * @param event
	 * @param treeId
	 * @param treeNode
	 */
	function zTreeFloorOnClick(event, treeId, treeNode) {
		pageLayoutSid=treeNode.id;
		floor_content=treeNode.floorContent;
		$("#pageLayoutSid_").val(pageLayoutSid);
		floor_type = treeNode.type;
		$("#channel_tab tbody").empty();
		$("#floor_product_tab tbody").empty();
		$("#brand_tab tbody").empty();
		$("#link_tab tbody").empty();
		if(floor_type==1){
			productShow();
			$("#brand_list,#link_list").hide();
			$("#product_list a").click();
			productList();
			function load(){
				$("#product_list a").click();
			} 
		}else if(floor_type==2){
			productShow();
			$("#product_list,#link_list").hide();
			$("#brand_list a").click();
			brandList();
			function load(){
				$("#brand_list a").click();  
			} 
		}else if(floor_type==3){
			productShow();
			$("#product_list,#brand_list").hide();
			$("#link_list a").click();
			linkList();
			function load(){
			    $("#link_list a").click();  
			} 
		}else{
			divManagerShow();
			$("#divTitle a").click();
			initFloor(pageLayoutSid);
			function load(){
			   $("#divTitle a").click();  
			} 
		}
	};
	
	/**
	 * 楼层Tree右键事件
	 * @param event
	 * @param treeId
	 * @param treeNode
	 */
	function FloorOnRightClick(event, treeId, treeNode) {
		// 优先创建右键菜单
		if($("#rMenuFloor").html() == undefined){
			$('body').after($("#floorTreeRightDiv").html());
			rMenuFloor = $("#rMenuFloor");
		}
		if(treeNode != null){
			fNodeId = treeNode.id;
	        floorType = treeNode.type;
	        //区分 根节点 /楼层 /块 选取不同的右键菜单
	        if(fNodeId==0||fNodeId==null){
	        	$("#rMenuFloor .dropdown-menu").find("li").css("display","none");
	        	$(".floor_root").show();
	        }else if(floorType==0){
	        	$("#rMenuFloor .dropdown-menu").find("li").css("display","none");
	        	$(".floor_two:gt(0)").show();
	        }else if(floorType==-1){
	        	$("#rMenuFloor .dropdown-menu").find("li").css("display","none");
	        	$(".floor_frist").show();
	        }else{
	        	$("#rMenuFloor .dropdown-menu").find("li").css("display","none");
	        	$(".floor_two").show();
	        }
			if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
				zTreeFloor.cancelSelectedNode();
				showRMenuFloor("root", event.clientX, event.clientY);
			} else if (treeNode && !treeNode.noR) {
				zTreeFloor.selectNode(treeNode);
				showRMenuFloor("node", event.clientX, event.clientY);
			}
		}
	};
	
	/**
	 * 楼层Tree右键菜单
	 * @param type
	 * @param x
	 * @param y
	 */
	function showRMenuFloor(type, x, y) {
		$("#rMenuFloor ul").show();
		if (type=="root") {
			$("#m_del").hide();
			$("#m_check").hide();
			$("#m_unCheck").hide();
		} else {
			$("#m_del").show();
			$("#m_check").show();
			$("#m_unCheck").show();
		}
		rMenuFloor.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

		$("body").bind("mousedown", onBodyMouseDownFloor);
	};
	function onBodyMouseDownFloor(event){
		if (!(event.target.id == "rMenuFloor" || $(event.target).parents("#rMenuFloor").length>0)) {
			rMenuFloor.css({"visibility" : "hidden"});
		}
	};
	
	/**
	 * 刷新节点
	 * @param obj
	 */
	function refreshTreeFloor(obj){
		var treeObj = $.fn.zTree.getZTreeObj("floorTree");
		var nodes = treeObj.getSelectedNodes();
		if(obj==3){
			treeObj.removeNode(nodes[0]);
		}else{
			if(zTreeFloor.getNodes()[0].id==0){
				initFloorTree(zTreeFloor.getSelectedNodes()[0].id);
				return;
			}
			if (nodes.length>0) {
				treeObj.reAsyncChildNodes(nodes[0], "refresh");
				
				if(obj==2){
					// 手动修改颜色
					nodes[0].name = floor_title;
					nodes[0].isShow = isShow;
					nodes[0].type = floor_type;
					if(isShow==0){
						nodes[0].iconSkin = "x";
						$("#"+nodes[0].tId+"_a").attr('style','color:red;');
					}else{
						nodes[0].iconSkin = "success";
						$("#"+nodes[0].tId+"_a").attr('style','color:green;');
					}
					treeObj.updateNode(nodes[0]);
				}
			}
		}
	};
	
	function divManagerShow(){
		$("#divTitle").show();
		$("#product_list,#brand_list,#link_list").hide();
		$("#divTitle").click();
	};
	function productShow(){
		$("#divTitle").hide();
		$("#product_list,#brand_list,#link_list").show();
		$("#product_list").click();
	};

	/**
	 * 楼层信息初始化
	 * @param channelSid
	 */
	function initFloor(channelSid) {
		if(channelSid==0){
			channelSid=channelId;
		}
		channelPagination = $("#channelPagination").myPagination(
		{
			panel : {
				tipInfo_on : true,
				tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
				tipInfo_css : {
					width : '25px',
					height : "20px",
					border : "2px solid #f0f0f0",
					padding : "0 0 0 5px",
					margin : "0 5px 0 5px",
					color : "#48b9ef"
				}
			},
			debug : false,
			ajax : {
				on : true,
				contentType : "application/json;charset=utf-8",
				url : __ctxPath + "/web/queryFloorList?channelSid="
						+ channelSid+"&rootId="+channelId,
				dataType : 'json',
				ajaxStart : function() {
					$(".loading-container").attr("class",
							"loading-container");
				},
				ajaxStop : function() {
					//隐藏加载提示
					$(".loading-container").addClass(
							"loading-inactive");
				},
				callback : function(data) {
					$("#channel_tab tbody").empty();
					//使用模板
					$("#channel_tab tbody").setTemplateElement(
							"floor-list")
							.processTemplate(data);
				}
			}
		});
	};
	/**
	 * 修改楼层下 块
	 * @param floor_id
	 * @param type
	 */
	function editFloorDiv(floor_id,type){
		loadFloorDivDetail(floor_id);
		if(type==-1){
			$("#editFloor").show();
			$("#style_list_edit").parent().show();
			$(".floor_div").text("修改楼层");
			$("#divSid_edit").val(floor_id);
			$("#title_edit").val(floor_title);
			$("#en_title_edit").val(floor_enTitle);
			$("#channel_link_edit").val(floor_channelLink);
			$("#style_list_edit").val(floor_style);
			if(floor_flag==1){
				$("#edit_floorFlag_0").click();
			}else if(floor_flag==0){
				$("#edit_floorFlag_1").click();
			}
			$('.spinner').spinner('value', floor_seq);
		}else if(type==0){
			$("#editFloor").show();
			$(".floor_div").text("修改块组");
			$("#style_list_edit").parent().parent().hide();
			$("#divSid_edit").val(floor_id);
			$("#title_edit").val(floor_title);
			$("#en_title_edit").val(floor_enTitle);
			$("#style_list_edit").val(floor_style);
			if(floor_flag==1){
				$("#edit_floorFlag_0").click();
			}else if(floor_flag==0){
				$("#edit_floorFlag_1").click();
			}
			$('.spinner').spinner('value', floor_seq);
		}else{
			$("#editFloorDIV").show();
			
			$("#divSid").val(floor_id);
			$("#div_title").val(floor_title);
			$("#div_en_title").val(floor_enTitle);
			if(floor_type==1){
				$("#divType_edit_0").click();
				$(".adddiv_selectlist").show();
			}else if(floor_type==2){
				$("#divType_edit_1").click();
			}else if(floor_type==3){
				$("#divType_edit_2").click();
			}
			$("#edit_div_style_list").val(floor_style);
			
			if(floor_flag==1){
				$("#edit_divflag_0").click();
			}else{
				$("#edit_divflag_1").click();
			}
			//$("#div_seq_edit").val(floor_seq);
			$('.spinner').spinner('value', floor_seq);
		}
	};
	/**
	 * 修改块验证
	 * @returns
	 */
	function validEditDivForm(){
		return $("#editDivForm").validate({
	        onfocusout: function (element) {
	            $(element).valid();
	        },
	        rules: {
	        	title: "required",
	        	seq : {
					required:true,
					digits:true
				},
	        	enTitle: "english"
	        }
	    });
	};
	/**
	 * 修改块-保存
	 * @returns
	 */
	function editDivForm(){
		if(validEditDivForm().form()){
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/web/modifyFloorDiv",
		        data: $("#editDivForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		var split_ = decodeURI($("#editDivForm").serialize()).split("&");
		        		floor_title = $("#div_title").val();
						isShow = split_[split_.length-1].split("=")[1];
						floor_type = split_[split_.length-3].split("=")[1];
		        		$(".editDiv").hide();
		        		$("#success1Body").text("修改成功!");
						$("#success1").attr("style", "z-index:9999");
						$("#success1").show();
	  	  				initFloor(pageLayoutSid);
	  	  				refreshTreeFloor(2);
		        	}else{
		        		$("#editFloorDIV").hide();
		        		$("#warning2Body").text("修改失败!");
						$("#warning2").attr("style", "z-index:9999");
						$("#warning2").show();
					}
		    	}
			});
		}
	};
	
	/**
	 * 修改楼层
	 */
	function editFloor(){
		$("#editFloor").show();
		$(".floor_div").text("修改楼层");
		loadFloorDivDetail(fNodeId);
		$("#divSid_edit").val(fNodeId);
		$("#title_edit").val(floor_title);
		$("#en_title_edit").val(floor_enTitle);
		$("#channel_link_edit").val(floor_channelLink);
		// --Fuelux Spinner--
		$('.spinner').spinner('value', floor_seq);
		$("#style_list_edit").val(floor_style);
		if(floor_flag==1){
			$("#edit_floorFlag_0").attr("checked",'checked');
		}else if(floor_flag==0){
			$("#edit_floorFlag_1").attr("checked",'checked');
		}
		rMenuFloor.css({"visibility" : "hidden"});
	};
	/**
	 * 查看楼层信息
	 */
	function loadFloorDetail(){
		$("#loadFloor").show();
		loadFloorDivDetail(fNodeId);
		$("#divSid_load").val(fNodeId);
		$("#title_load").val(floor_title);
		$("#en_title_load").val(floor_enTitle);
		$("#channel_link_load").val(floor_channelLink);
		$("#floor_seq_load").val(floor_seq);
		$("#style_list_load").val(floor_style);
		if(floor_flag==1){
			$("#load_divFlag").attr("value",'是');
		}else if(floor_flag==0){
			$("#load_divFlag").attr("value",'否');
		}
		rMenuFloor.css({"visibility" : "hidden"});
	};
	/**
	 * 加载楼层/块信息
	 * @param sid
	 */
	function loadFloorDivDetail(sid){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/queryFloorDiv",
			dataType : "json",
			async : false, 
			data : {
				"sid" : sid
			},
			success : function(response) {
				floor_title = response.name;
				floor_enTitle = response.enTitle;
				floor_channelLink = response.channelLink;
				floor_seq = response.seq;
				floor_style = response.styleList;
				floor_type = response.type;
				floor_flag = response.pageType;
			}
		});
	};

	/**
	 * 添加块组/块按钮
	 */
	function addDiv(){
		$(".error").html("");
		$("#floorDIV").show();
		clearInput();
		// --Fuelux Spinner--
		$('.spinner').spinner("value", 1);
		$("#pageLayoutSid").val(fNodeId);
	};
	/**
	 * 添加楼层
	 */
	function addFloor(){
		$("#addFloor").show();
		clearInput();
		// --Fuelux Spinner--
		$('.spinner').spinner('value', 1);
		$("#pageLayoutSid").val(fNodeId);
	};
	function addFloorNode(){
		$("#addFloor").show();
		clearInput();
		// --Fuelux Spinner--
		$('.spinner').spinner('value', 1);
		$("#add_channel_sid").val(channelId);
		rMenuFloor.css({"visibility" : "hidden"});
	};
	
	/**
	 * 添加楼层验证
	 * @returns
	 */
	function validAddForm() {
	    return $("#floorForm").validate({
	        onfocusout: function (element) {
	            $(element).valid();
	        },
	        rules: {
	        	title: "required",
	        	seq : {
					required:true,
					digits:true
				},
	        	enTitle: "english",
	        	channelLink: "url"
	        }
	    });
	};
	/**
	 * 保存楼层
	 */
	function saveFloorFrom(){
		if(validAddForm().form()){
	  		$.ajax({
		        type:"post",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        dataType: "json",
		        ajaxStart: function() {
			       	 $("#loading-container").attr("class","loading-container");
			        },
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	 },300);
		        },
		        url: __ctxPath + "/web/addFloorDiv",
		        data: $("#floorForm").serialize(),
		        success: function(response) {
		        	if(response.success == 'true'){
		        		$("#floorDIV").hide();
		        		$("#addFloor").hide();
		        		$("#success1Body").text("添加成功!");
		    			$("#success1").show();
		    			refreshTreeFloor(1);
		        	}else{
		        		if(response.msg != undefined){
		        			$("#floorDIV").hide();
		        			$("#warning2Body").text(response.msg);
		        			$("#warning2").show();
		        		}else{
		        			$("#floorDIV").hide();
		        			$("#warning2Body").text("添加失败!");
		        			$("#warning2").show();
		        		}
					}
	        	}
			});
		}
	};
	
	/**
	 * 修改楼层验证
	 * @returns
	 */
	function validEditForm() {
	    return $("#editFloorForm").validate({
	        onfocusout: function (element) {
	            $(element).valid();
	        },
	        rules: {
	        	title: "required",
	        	seq : {
					required:true,
					digits:true
				},
	        	enTitle: "english",
	        	channelLink: "url"
	        }
	    });
	};
	/**
	 * 修改楼层
	 */
	function editFloorForm(){
		if(validEditForm().form()){
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/web/modifyFloorDiv",
		        data: $("#editFloorForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		var split_ = decodeURI($("#editFloorForm").serialize()).split("&");
		        		floor_title = $("#title_edit").val();
						isShow = split_[split_.length-1].split("=")[1];
		        		$(".editDiv").hide();
		        		$("#success1Body").text("修改成功!");
		    			$("#success1").show();
  	  					initFloor(pageLayoutSid);
  	  					refreshTreeFloor(2);
		        	}else{
		        		$("#editFloor").hide();
		        		$("#warning2Body").text("修改失败!");
		    			$("#warning2").show();
					}
		    	}
			});
		}
	};
	/**
	 * 保存楼层块验证
	 */
	function validSaveDivForm(){
		return $("#floorDivForm").validate({
	        onfocusout: function (element) {
	            $(element).valid();
	        },
	        rules: {
	        	title: "required",
	        	seq : {
					required:true,
					digits:true
				},
	        	enTitle: "english"
	        }
	    });
	};
	/**
	 * 保存楼层块
	 */
	function saveDivFrom(){
		$(".pageLayoutSid").val(pageLayoutSid);
		if(validSaveDivForm().form()){
	  		$.ajax({
		        type:"post",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        dataType: "json",
		        ajaxStart: function() {
			       	 $("#loading-container").attr("class","loading-container");
			        },
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	 },300);
		        },
		        url: __ctxPath + "/web/addFloorDiv",
		        data: $("#floorDivForm").serialize(),
		        success: function(response) {
		        	if(response.success == 'true'){
		        		$("#floorDIV").hide();
		        		$("#addFloor").hide();
		        		$("#success1Body").text("添加成功返回列表!");
		    			$("#success1").show();
		    			refreshTreeFloor();
	  	  			    initFloor(pageLayoutSid);
		        	}else{
		        		if(response.msg != undefined){
		        			$("#floorDIV").hide();
		        			$("#warning2Body").text(response.msg);
		        			$("#warning2").show();
		        		}else{
		        			$("#floorDIV").hide();
		        			$("#warning2Body").text("添加失败!");
		        			$("#warning2").show();
		        		}
					}
	        	}
			});
		}
	};
	
	//楼层下商品列表
	function productList(){
		var pageLayoutSid=$("#pageLayoutSid_").val().trim();
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/productList",
			dataType : "json",
			data : {
				"pageLayoutSid" : pageLayoutSid
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			success : function(data) {
				//使用模板
				$("#floor_product_tab tbody").setTemplateElement(
						"floor_product-list")
						.processTemplate(data);
			}
		}); 
	};
	/**
	 * 楼层块中添加商品
	 */
	function addPro(){
		$("#addProductDIV").show();
		//productQuery(); 禁用: 针对add_floor_product.js 初始化就加载商品列表 改为点击添加商品在加载
		initProduct();
		$("input[type='checkbox']:checked").each(function(i, team){
			$(this).click();
		});
		var pageLayoutSid=$("#pageLayoutSid_").val().trim();
		
		//获取渠道下所有门店
//		$.ajax({
//			type : "post",
//			contentType : "application/x-www-form-urlencoded;charset=utf-8",
//			url : __ctxPath + "/web/getShopCode",
//			dataType : "json",
//			data : {"channelCode":channelCode},
//			ajaxStart : function() {
//				$("#loading-container").attr("class",
//						"loading-container");
//			},
//			ajaxStop : function() {
//				//隐藏加载提示
//				setTimeout(function() {
//					$("#loading-container")
//							.addClass("loading-inactive")
//				}, 300);
//			},
//			success : function(response) {
//				var productShopCode=$(".shopeCode_select");
//				productShopCode.html("");
//				var option1 = $("<option value=''>全部</option>");
//				option1.appendTo(productShopCode);
//				for(i=0;i<response.data.length;i++){
//					var opt=$('<option id='+response.data[i].shopCode+' value='+response.data[i].shopCode+'>'+response.data[i].shopName+'</option>');
//					$("#shopCode_select").append(opt);
//				}
//			}
//		});
	};
	/**
	 * 楼层块中删除商品
	 * @returns {Boolean}
	 */
	function delPro(){
		var checkboxArray = [];
		var sid;
		$("input[type='checkbox']:checked").each(function(i, team) {
			var proSid = $(this).val();
			sid=proSid;
			checkboxArray.push(proSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除的列!");
			$("#warning2").show();
			return false;
		}
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i]+",";
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				var pageLayoutSid=$("#pageLayoutSid_").val().trim();	
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/web/delProduct",
					dataType : "json",
					data : {
						"sid" : value,
						"pageLayoutSid" : pageLayoutSid
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").show();
							productList();
						} else {
							$("#warning2Body").text("删除失败!");
							$("#warning2").show();
						}
						return;
					}
				});
			}
		}); 
	};
	/**
	 * 楼层下品牌列表
	 */
	function brandList(){
		var pageLayoutSid=$("#pageLayoutSid_").val().trim();
		
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/brandList",
			dataType : "json",
			data : {
				"pageLayoutSid" : pageLayoutSid
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			success : function(data) {
				//使用模板
				$("#brand_tab tbody").setTemplateElement(
						"brand-list")
						.processTemplate(data);
			}
		}); 
	};
	/**
	 * 添加楼层下品牌
	 */
	function addFloorBrand(){
		if(zTreeChannel.getSelectedNodes().length == 0){
			$("#warning2Body").text("请选择频道!");
			$("#warning2").show();
			return false;
		}
		if(zTree.getSelectedNodes().length==0){
			if(zTreeFloor.getSelectedNodes().length==0){
				$("#warning2Body").text("请选择导航!");
				$("#warning2").show();
				return false;
			}
		}
		
		$("#addBrandDIV").show();
		initBrand();
		$("input[type='checkbox']:checked").each(function(i, team){
			$(this).click();
		});
		var pageLayoutSid=$("#pageLayoutSid_").val().trim();
	};
	/**
	 * 删除楼层下品牌
	 * @returns {Boolean}
	 */
	function delBrand(){
		var checkboxArray = [];
		var sid;
		$("input[type='checkbox']:checked").each(function(i, team) {
			var brandSid = $(this).val();
			sid=brandSid;
			checkboxArray.push(brandSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除的列!");
			$("#warning2").show();
			return false;
		}
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i]+",";
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				var pageLayoutSid=$("#pageLayoutSid_").val().trim();	
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/web/delBrand",
					dataType : "json",
					data : {
						"sid" : value,
						"pageLayoutSid" : pageLayoutSid
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").show();
							brandList();
						} else {
							$("#warning2Body").text("删除失败!");
							$("#warning2").show();
						}
						return;
					}
				});
			}
		}); 
	};
	/**
	 * 楼层下引导链接列表
	 */
	function linkList(){
		var pageLayoutSid=$("#pageLayoutSid_").val().trim();
		
		 $.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/linkList",
			dataType : "json",
			data : {
				"pageLayoutSid" : pageLayoutSid
			},
			ajaxStart : function() {
				$("#loading-container").attr("class",
						"loading-container");
			},
			ajaxStop : function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container")
							.addClass("loading-inactive")
				}, 300);
			},
			success : function(data) {
				//使用模板
				$("#link_tab tbody").setTemplateElement(
						"link-list")
						.processTemplate(data);
			}
		}); 
	};
	/**
	 * 添加引导链接
	 */
	function addLink(){
		$(".error").html("");
		$("#addLinkForm")[0].reset();
		$("#msg_pict").addClass("hide");
		$("#hidden_pict").val("");
		$("#msg_subTitle").addClass("hide");
		$("#hidden_subTitle").val("");
		$('.spinner').spinner('value', 1);
		$("#addLinkDIV").show();
		$("#pageLayoutSid_link").val($("#pageLayoutSid_").val().trim());
	};
	
	/**
	 * 引导链接验证
	 * @returns
	 */
	function validformAddLink() {
	    return $("#addLinkForm").validate({
	        onfocusout: function (element) {
	            $(element).valid();
	        },
	        rules: {
	            mainTitle: {
	                required: true,
	                checkLinkTitle: true
	            },
	            seq : {
					required:true,
					digits:true
				},
	            pict: "url",
	            subTitle: "url",
	            link: {
	            	required: true,
	            	url: true
	            }
	        }
	    });
	};
	/**
	 * 添加引导链接
	 */
	function addLinkForm(){
		 if($("#id_pict").val()==""){
			 alert("图片地址为空，请选择文件！")
			 return;
		 }
		if($("#id_subTitle").val()==""){
			alert("背景图片为空，请选择文件！");
			return;
		}
		
		if(validformAddLink().form()){
	  		$.ajax({
		        type:"post",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        dataType: "json",
		        ajaxStart: function() {
			       	 $("#loading-container").attr("class","loading-container");
			        },
		        ajaxStop: function() {
		          //隐藏加载提示
		          setTimeout(function() {
		       	        $("#loading-container").addClass("loading-inactive")
		       	 },300);
		        },
		        url: __ctxPath + "/web/addLink",
		        data: $("#addLinkForm").serialize(),
		        success: function(response) {
		        	if(response.success == 'true'){
		        		$("#addLinkDIV").hide();
		        		clearInput();
		        		$("#success1Body").text("添加成功!");
						$("#success1").show();
						linkList();
					}else{
						$("#addLinkDIV").hide();
						clearInput();
						$("#warning2Body").text("添加失败!");
						$("#warning2").show();
					}
		        	//重置楼层引导链接添加表单
		        	$("#add_mainTitle").val("");
		        	$("#add_subTitle").val("");
		        	$("#add_pict").val("");
		        	$("#add_link").val("");
		        	$("#add_seq").val("");
		        	$("#link_isShow_1").attr("checked","checked");
	        	}
			});
		}
	};
	
	/**
	 * 修改引导链接
	 * @returns {Boolean}
	 */
	function editLink(){
		$("#editLinkForm")[0].reset();
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
		});
		if (checkboxArray.length > 1) {
			$("#warning2Body").text("只能选择一列!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要修改的列!");
			$("#warning2").show();
			return false;
		}
		$("#editLinkDIV").show();
		var value=checkboxArray[0];
		$("#linkSid").val(value);
		$("#mainTitle").val($("#linkMainTitle_" + value).text().trim());
		var linkSubTitle_ = $("#linkSubTitle_" + value).text().trim();
		if(linkSubTitle_!=''){
			var linkSub_title =$("#linkSubTitle_" + value).text().trim().split("com")[1]+"com"+ $("#linkSubTitle_" + value).text().trim().split("com")[2];
			$("#hidden_subTitleEdit").val(linkSub_title);
			$("#msg_subTitleEdit").removeClass("hide");
			$("#msg_subTitleEdit").html("<img id='img_subTitleEdit' width='100' height='100' src='"+linkSubTitle_+"' />");
		}else{
			$("#msg_subTitleEdit").addClass("hide");
			//$("#msg_subTitleEdit").html("");
		}
		var titleImg_ = $("#linkPic_" + value).text().trim();
		if(titleImg_!=''){
			var title_Img =$("#linkPic_" + value).text().trim().split("com")[1]+"com"+ $("#linkPic_" + value).text().trim().split("com")[2];
			$("#hidden_pictEdit").val(title_Img);
			$("#msg_pictEdit").removeClass("hide");
			$("#msg_pictEdit").html("<img id='img_pictEdit' width='100' height='100' src='"+titleImg_+"' />");
		}else{
			$("#msg_pictEdit").addClass("hide");
			//$("#msg_pictEdit").html("");
		}
		$("#link_").val($("#link_" + value).text().trim());
		$('.spinner').spinner('value', $("#seq_" + value).text().trim());
		
		$("#img_pict_edit").attr("src",$("#pict").val());
		$("#img_subTitle_edit").attr("src",$("#subTitle").val());
		
		if($("#flag_" + value).val().trim()==1){
			$("#edit_isShow_0").click();
		}else{
			$("#edit_isShow_1").click();
		}
	};
	/**
	 * 修改引导链接验证
	 * @returns
	 */
	function validformEditLink() {
		return $("#editLinkForm").validate({
			onfocusout: function (element) {
				$(element).valid();
			},
			rules: {
				mainTitle: {
					required: true,
					checkLinkTitle: true
				},
				seq : {
					required:true,
					digits:true
				},
				pict: "url",
				subTitle: "url",
				link: {
					required: true,
					url: true
				}
			}
		});
	};
	/**
	 * 修改引导链接
	 */
	function editLinkForm(){
		if(validformEditLink().form()){
			$.ajax({
		        type:"post",
		        dataType: "json",
		        contentType: "application/x-www-form-urlencoded;charset=utf-8",
		        url:__ctxPath + "/web/modifyLink",
		        data: $("#editLinkForm").serialize(),
		        success:function(response) {
		        	if(response.success == 'true'){
		        		$("#editLinkDIV").hide();
		        		$("#success1Body").text("修改成功!");
						$("#success1").show();
				linkList();
		        	}else{
		        		$("#editLinkDIV").hide();
		        		$("#warning2Body").text("修改失败!");
						$("#warning2").show();
					}
		    	}
			});
		}
	};
	/**
	 * 删除引导链接
	 * @returns {Boolean}
	 */
	function delLink(){
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var linkSid = $(this).val();
			checkboxArray.push(linkSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除的列!");
			$("#warning2").show();
			return false;
		}
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value=value+","+checkboxArray[i];
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/web/delLink",
					dataType : "json",
					data : {
						"sid" : value
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").show();
							linkList();
						} else {
							$("#warning2Body").text("删除失败!");
							$("#warning2").show();
						}
						return;
					}
				});
			}
		}); 
	};
	
	/**
	 * 批量删除块
	 * @returns {Boolean}
	 */
	function delDivByGroup(){
		var checkboxArray = [];
		var sid;
		$("input[type='checkbox']:checked").each(function(i, team) {
			var divSid = $(this).val();
			sid=divSid;
			checkboxArray.push(divSid);
		});
		if (checkboxArray.length == 0) {
			$("#warning2Body").text("请选取要删除的列!");
			$("#warning2").show();
			return false;
		}
		
		var value="";
		for(i=0;i<checkboxArray.length;i++){
			value+=checkboxArray[i]+",";
		}
		bootbox.setDefaults("locale","zh_CN");
		bootbox.confirm("确定删除吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/web/delDiv",
					dataType : "json",
					data : {
						"sid" : value
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if (response.success == "true") {
							$("#success1Body").text("删除成功!");
							$("#success1").show();
							initFloor(pageLayoutSid);
							initFloorTree();
						} else {
							$("#warning2Body").text("删除失败!");
							$("#warning2").show();
						}
						return;
					}
				});
			}
		});  
	};
	
	function delFloorDiv(floor_id){
		fNodeId=floor_id;
		delDiv();
	};
	/**
	 * 删除楼层确认信息
	 */
	function delDiv(){
		bootbox.setDefaults("locale","zh_CN");
		if(hasContent==1){
			bootbox.confirm("该楼层下不为空,确定删除吗？", function(r){
				if(r){
					delFloorAjax();
				}
			});
		}else{
			bootbox.confirm("确定删除吗？", function(r){
				if(r){
					delFloorAjax();
				}
			});
		}
		rMenuFloor.css({"visibility" : "hidden"});
	};
	/**
	 * 提交删除楼层方法
	 */
	function delFloorAjax(){
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/delDiv",
			dataType : "json",
			data : {
				"sid" : fNodeId
			},
			success : function(response) {
				if (response.success == "true") {
					$("#success1Body").text("删除成功!");
					$("#success1").show();
					initFloor(pageLayoutSid);
					refreshTreeFloor(3);
				} else {
					$("#warning2Body").text("删除失败!");
					$("#warning2").show();
				}
				return;
			}
		});
	};
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		//$("#pageBody").load(__ctxPath+"/jsp/nav/GetChannelTree.jsp");
	};
	