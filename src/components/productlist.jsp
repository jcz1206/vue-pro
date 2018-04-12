<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<title>商品列表</title>
    <%@ include file="../common/common_resource.jsp" %>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/product/goodsSpuList.css'/>?v=${version}">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/product/tcSku.css'/>?v=${version}">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/product/addCartLayer.css'/>?v=${version}5">
</head>
<body>
<div id="prodList"  v-cloak>
    <div class="header" id="headerSearch" v-if="isShowClassifySear!=0"><%-- --%>
        <a class="fh urlback-w" href="javascript:;" @click="changeSearch(0)"></a>
        <%--<img src="<%=request.getContextPath()%>/resources/images/m2.png" class="magnifier">--%>
        <form action="" onsubmit="return false" style="max-width: 640px;">
        <input type="search" value="${name }" id="query_condition" v-model="search.productName" style="height: 30px; border:none; width: calc(100% - 85px);" placeholder="请输入商品名称" @search="searchProductByCondition1()">
            <a href="javascript:void(0)" class="sousuo" @click="searchProductByCondition1()" style="color:#fff">搜索</a>
        </form>
        <%--<a href="javascript:void(0)" class="sousuo" onclick="searchProductByCondition1()">搜索</a>--%>
    </div>
    <div class="header" id="headerCategroy"  v-if="isShowClassifySear==0">
        <a class="fh urlback-w" href="javascript:;" onclick="history.back(-1);"></a>
        <span id="option" @click="showBigClassify()"><span id="cName">{{classifyName}}</span><i class="icon-down3" v-if="classifyName!=''"></i></span>
        <a href="javascript:void(0)" class="sousuo2" @click="changeSearch(1)"></a>
    </div>
    <div class="searchBox" v-if="!(isShowClassifySear==1&&isGoBack==0)"><%----%>
      <ul>
         <li id="classify" @click="showClassify()" :class="{'on': (isShowClassify==1) }">分类<i class="icon-down2"  v-bind:class="{'on': (isShowClassify==1) }"></i></li>
         <li id="brand" @click="showBrand()" :class="{'on': (isShowBrand==1) }">品牌<i class="icon-down2" v-bind:class="{'on': (isShowBrand==1) }"></i></li>
          <li class="sales"  id="sales" @click="saleSortFun()" :class="{'on': (search.saleSort!=0) }">销售<i class="icon-down-small"  v-bind:class="{'on': (search.saleSort==1),'on2':(search.saleSort==2) }"></i></li>
          <li class="price" id="price"  @click="priceSortFun()" :class="{'on': (search.priceSort!=0) }">价格<i class="icon-down-small"  v-bind:class="{'on': (search.priceSort==1),'on2':(search.priceSort==2) }"></i></li>
          <li id="more"  @click="showMore()" :class="{'on':(isShowMore==1)}">更多&nbsp;</li>
      </ul>
    </div>
    <div class="grade-eject" v-bind:class="{'grade-w-roll': (isShowClassify==1) }" >
        <div  class="grade-w">
        <ul id="gradew">
            <!-- 二级分类数据 -->
            <li v-for="item in categoryList" @click="showClassify2(item.id)">{{item.categoryName}}</li>
        </ul>
        </div>
        <div  class="grade-t">
        <ul id="gradet">
            <!-- 三级分类数据 -->
            <li v-for="item in categoryList2" @click="classifySearch(item.id)">{{item.categoryName}}</li>
        </ul>
        </div>
    </div>
    <div class="Sort-eject"  v-bind:class="{'grade-w-roll': (isShowBrand==1) }" > <%--Sort-height--%>
        <div class="Sort-Sort">
        <ul id="Sort-Sort">
            <li @click="brandSearch('')">所有品牌</li>
            <!-- 品牌列表标题 -->
            <li v-for="item in brandList" @click="brandSearch(item.id)">{{item.brand_name}}</li>
        </ul>
        </div>
    </div>
    <div class="more-box" v-if="isShowMore==1"  v-bind:class="{'on': (isShowMore==1) }">
       <div class="moremain">
         <P>价格区间</P>
         <ul>
             <li><input type="text" placeholder="最低价" id="lowp" v-model="search.priceBegin"></li>
             <li class="rivers"><i></i></li>
             <li><input type="text" placeholder="最高价" id="highp" v-model="search.priceEnd"></li>
         </ul>
         <div class="submit-box">
             <a href="javascript:;" @click="priceSearch(0)">重置</a>
             <a class="yes" href="javascript:;" @click="priceSearch(1)">确定</a>
         </div>
       </div>
    </div>
    <input type="hidden" name="userId" value="${userId}">
    <div class="hideBox" :class="{'on':isShowBigClassify}">
       <div class="hideContent" id="hideContent" >
          <ul>
              <li v-for="item in bigClassify"><a @click="getProByTopCId(item.id,item.categoryName);"  :class="{'on':(categoryId==item.id)}" style="font-size: medium">{{item.categoryName}}</a></li>
             <%--<li><a @click="getProByTopCId(this);" cId="187eef3c4525485493396aa3340da7c8" shopId="" style="font-size: medium">水工材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="1a73630806934f91a29b839df8320771" shopId="" style="font-size: medium">电工材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="f7dc8b599f264e5db1bdf4dd5a240040" shopId="" style="font-size: medium">木工材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="4a75488957c94994b7e7c531eb7373d2" shopId="" style="font-size: medium">油漆材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="8c87be61e9474218919b45d79b12840d" shopId="" style="font-size: medium">五金材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="4ffbd38c864c42149bca0a9c4b2fb1b5" shopId="" style="font-size: medium">瓦工材料</a></li>
             <li><a @click="getProByTopCId(this);" cId="9c9e33f5c4734f46825763d4b85d5b32" shopId="9df6565bf2f742d3afb75eb6b1d14791" style="font-size: medium">家电</a></li>
             <li><a @click="getProByTopCId(this);" cId="af7234dd21c74cfca7f6dc85bcdb1af4" shopId="" style="font-size: medium">家具</a></li>--%>
          </ul>
       </div>
    </div>


    <div id="wrapper">
        <div id="scroller">
            <div class="listBox" v-if="!(isShowClassifySear==1&&isGoBack==0)"><%----%>
                <ul v-for="item in prodList" class="price_info_ul" >
                   <%-- <p class="goodsTagPic"></p>--%>
                    <li class="goodsPic" :data-id="item.id" :data-did="item.defProductId" :stock="item | sumStock" @click="toProductDetail(item)">
                        <img :src="item.itemPicUrl">
                    </li>
                    <li class="goodsInfo" :class="{gray:(item.stock<=0)}">
                        <p class="goodsName" @click="toProductDetail(item)" id="goodsName">{{item.assembleName}}</p>
                        <%--<p class="goodsSize" onclick="toProductDetail(this)">{{item.brandName}}&nbsp;{{item.specification}}&nbsp;{{item.color}}&nbsp;{{item.unit}}</p>--%>
                        <div class="goodsMoney">
                            <span v-if="memType=='3'&&showPrice=='0'">加入会员,查看价格</span>
                            <span v-if="memType!='3'|| showPrice=='1'">￥{{item.displayPrice.toFixed(2)}}</span>
                            <div class="stock">库存:{{item.stock}}<%--{{item | sumStock}}--%></div>
                            <div class='shoppingct' @click='addIntoShopcart(item)' v-if="item.stock>0"><em class="icon-shopcart"></em></div>
                            <div v-if="item.stock<=0"><em class="nostock"></em></div>
                        </div>
                    </li>
                </ul>
                <%--<p class="more" id="queryMore" v-on:click="listData">{{message}}</p>--%>

            </div>
        </div>
    </div>

<!--规格选择-->
    <div class="allchoose-box" v-if="selectProd!=''" v-bind:class="{'on': (isShowAdd==1) }">
        <div class="choosebg"  @click="closeAdd()"></div>
        <div class="choosedetail">
            <div class="choosemain">
                <ul class="price_info_ul"  style="overflow: hidden; ">
                    <li class="goodsPic"><img :src="selectProd.productPic"></li>
                    <li class="goodsInfo">
                        <p class="goodsName">{{selectProd.productName}}</p>
                        <div class="goodsMoney">
                            <div  class="goodsMoneyc">
                                <span v-if="memType=='3'&&showPrice=='0'">加入会员,查看价格</span>
                                <span v-if="memType=='3'&&showPrice=='1'&&showPrePrice=='0'">￥{{selectProd.originalPrice.toFixed(2)}}</span>
                                <span v-if="memType!='3'|| (showPrice=='1'&&showPrePrice=='1')">￥{{selectProd.promoteSale.toFixed(2)}}</span>
                                <s v-if="(memType!='3'|| (showPrice=='1'&&showPrePrice=='1'))&&selectProd.originalPrice>0">￥{{selectProd.originalPrice.toFixed(2)}}</s>
                            </div>
                            <div class="stock goodsSize">库存:{{selectProd.stock}}</div>
                        </div>
                    </li>
                </ul><%--price_info_ul E--%>
                <em class="icon-close all-close" @click="closeAdd()"></em>
                <%--<img src="<c:url value='/resources/images/product/close.png'/>" class="all-close">--%>
                <div class="scrollbox">
                    <div idd="wrapper2" class="scrollboxpadding">
                        <div idd="scroller2">
                        <div class="choose-common" v-for="item in selectAttrGroup">
                            <h1>{{item.attrName}}</h1>
                            <ul><%--checkDisable(item2.attrValueId)--%>
                                <li v-for="item2 in item.valueList"  @click="selectAttr(item.attrId,item2,item2.isDisable)" v-bind:class="{'disabled':item2.isDisable,'on':item2.isSelected}"><a>{{item2.attrValue}}</a></li>
                          </ul>
                        </div>
                        <div class="choose-select">
                            <span>购买数量</span>
                            <ul>
                                <li class="decrease commonselect disabled" @click="clickChangeBuyNum(0)" @touchend="touchChangeBuyNum(0)"></li>
                                <li class="number-choose"><input type="text" v-model="buyNum" value="1" @input="fillChangeBuyNum(0)" @blur="fillChangeBuyNum(1)" @focus="fillChangeBuyNum(-1)"></li>
                                <li class="addnum commonselect" @click="clickChangeBuyNum(1)" @touchend="touchChangeBuyNum(1)"></li>
                            </ul>
                        </div><%--choose-select E--%>
                    </div>
                    </div>
                </div><%--scrollbox E--%>
            </div>
            <%--choosemain E--%>
            <div class="joincart">
                <ul class="cart-bottom">
                    <li class="sc"><em class="icon-collect" v-bind:class="{'on':(selectProd.isCollect==1)}" @click="collectProd()"></em><%--<img src="<c:url value='/resources/images/product/sc.png'/>">--%><a>收藏</a></li>
                    <li class="gwc" @click="gotoShopCart()"><em class="icon-shopcart2"></em><%--<img src="<c:url value='/resources/images/product/gwc.png'/>">--%><a>购物车</a></li>
                    <li class="addcart" v-bind:class="{'disabled': (selectProd.stock<=0) }"><%--(companyOrderType=='0'&&memType=='1')||--%>
                        <a v-if="selectProd.stock>0" @click="addToShopCart()" href="javascript:;">加入购物车</a>
                        <a v-if="selectProd.stock<=0" href="javascript:;">暂无库存</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script src="<c:url value='/resources/plugins/layer-mobile/layer.js'/>"></script>
<script src="<c:url value="/resources/js/vue.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/resources/plugins/iscroll/iscroll-probe.js"/>?v=${version}" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/plugins/simpScroller/simpScroller.css'/>">
<script src="<c:url value="/resources/plugins/simpScroller/simpScroller.js"/>" type="text/javascript"></script>
<script type="text/javascript">
    var wh=0;//浏览器的高度
    wh=$(window).height();
    var interval;
//    $(window).resize(function(){
//        if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
//
//           /* dh=$(".choosedetail").height();
//            $(".choosedetail").resize(function () {
//                var $choosed = $(".choosedetail");
//                if ($(".choosedetail").height() < dh) {
//                    if (!$choosed.hasClass("on")) {
//                        $choosed.addClass("on");
//                    }
//                } else {
//                    if ($choosed.hasClass("on")) {
//                        $choosed.removeClass("on");
//                    }
//                }
//            });*/
//        }
//    });
var myScroll,myScroll2,
        isLoading = false,
        isComplete = false;;
var apiURL = '<%=request.getContextPath()%>/';

var savebase={};
var myvue = new Vue({
    el:'#prodList',
    data:{
        memType:'${sessionScope.loginMember.memberType}',
        companyOrderType: "0",//装饰公司是否可以购买
        showPrice: "0",//是否显示价格
        showPrePrice: "0",//显示优惠价
        prodList:'',//循环的商品列表
        search:{
            key:1,
            type : 1,
            uid:'${userId}',
            categoryId : this.getQueryString("categoryId"),
            brandId : "",
            productName : "",
            saleSort: 0,
            priceSort:0,
            priceBegin:"",
            priceEnd:"",
            iDisplayStart : -1,
            iDisplayLength : 20
        },//搜索条件
        message:"加载中...",
        isNextPage:0,//是否有下一页
        categoryId:this.getQueryString("categoryId"),
        categoryList:'',//循环使用的1级分类
        categoryList2:'',//循环使用的2级分类
        categorySecondList:'',//1级分类key和2级分类数组
        brandList:'',//循环的品牌数组
        categoryBrandList:'',//分类key与品牌数组
        params:{
            typeId:this.getQueryString("categoryId"),
            productName:""
        },
        classifyName:' ',//当前页面分类名称
        isShowClassifySear:0,//显示此分类的搜索框
        isGoBack:0,//0 只是关闭这个搜索框 1表示返回上一页
        isShowBigClassify:0,//是否显示分类div
        isShowClassify:0,//是否显示分类div
        isShowBrand:0,//是否显示品牌div
        isShowMore:0,//是否显示更多筛选项
        isShowAdd:0,//是否显示加入购物车的弹层
        selectProdShop:'',//商品所属店铺
        selectSpu:'',//将要加入购物车的产品 重构后的map接口 key是productid
        defProd:'',//没有选择任何商品时，页面展示的商品数据信息(弹层中展示的数据)
        selectProd:'',//将要加入购物车的商品仅用于页面展示
        selectAttrGroup:[],//选择商品属性 仅用于展示数据
        changeSaleAttr:[],//选择商品属性 用于判断去灰化哪些不能选择的属性值
        selectAttrList:[],//选中的销售属性列表
        buyNum:1, //加入购物车的个数
        isCanbuy:1,//防止加入购物车重复提交的参数 0不允许加入购物车
        bigClassify:null//一级大分类列表
    },
    filters:{
        sumStock:function(spu){//统计spu的库存量
            var skuList=spu.skuList;
            var totalStock=0;
            for(var i=0;i<skuList.length;i++){
                totalStock+=skuList[i].stock;
            }
            spu.stock=totalStock;
            return totalStock;
        }
    },
    /*watch:{
        isShowClassify:function(val){
            if(val==1){
                this.$nextTick(function(){
                    document.addEventListener('touchmove', function (e) { e.returnValue = true; }, false);
                });
            }else{
                this.$nextTick(function(){
                    document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
                });
            }
        },
        isShowBrand:function(val){
            if(val==1){
                this.$nextTick(function(){
                    document.addEventListener('touchmove', function (e) { e.returnValue = true; }, false);
                });
            }else{
                this.$nextTick(function(){
                    document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
                });
            }
        }
    },*/
    computed:{
    },
    mounted:function(){
        this.$nextTick(function () {
            simpScroller(document.querySelector(".grade-w"),{hideScrollBar:1});
            simpScroller(document.querySelector(".grade-t"),{hideScrollBar:1});
            simpScroller(document.querySelector(".Sort-Sort"),{hideScrollBar:1});
            // 代码保证 this.$el 在 document 中
           /* if(sessionStorage.saveList==1){
                sessionStorage.setItem("saveList",0);
                console.log(myvue);
                myvue._data=sessionStorage._data;
                console.log("====");
                console.log(JSON.stringify(sessionStorage._data));
                alert(1);
            }else {*/

                this.initList();

            /*}*/
        })      
    },
    methods:{
        initList:function(){
            this.$nextTick(function () {
                this.classifyName=decodeURI(this.getQueryString("title"));
                var productNameSear = this.getQueryString("productName");
                if (productNameSear != null) {
                    productNameSear = decodeURI(productNameSear);
                    $("#headerSearch").show();
                    this.isGoBack = 1;
                    this.search.productName = productNameSear;
                    this.params.productName = productNameSear;
                    this.isShowClassifySear = 1;
                    if (productNameSear != "") {
                        this.scrollData();
                        this.listData();
                    }
                } else {
//                    this.showClassifyTitle();
                    this.scrollData();
                    this.listData();
                }
            });
        },
        scrollData:function(){
            var _this=this;
            myScroll = new IScroll('#wrapper', {
                probeType: 3,
                scrollbars: true,
                mouseWheel: true,
                click:true, // 使子元素可点击
                interactiveScrollbars: true,
                shrinkScrollbars: 'scale',
                fadeScrollbars: true
            });

            myScroll.on('scrollEnd',function(){
                var px = Math.round(this.y - this.maxScrollY);
                if( px < 10 && !isLoading && !isComplete ){
                    isLoading = true;
                    _this.listData();
                }
            });
        },
        searchData:function(){//搜索商品数据
            this.isNextPage=0;
            this.search.iDisplayStart= -1;
            this.isShowClassify=0;//是否显示分类div
            this.isShowBrand=0;//是否显示品牌div
            this.isShowMore=0;//是否显示更多筛选项
            this.isShowAdd=0;//是否显示加入购物车的弹层
            this.prodList="";
            this.selectProdShop='';;
            this.selectSpu='';;
            this.defProd='';;
            this.selectProd='';
            this.selectAttrGroup=[];;
            this.changeSaleAttr=[];
            this.selectAttrList=[];
            this.buyNum=1;
            this.listData();
        },
        listData:function(){//查询商品数据
            var _this=this;
            if(_this.isNextPage==0) {
                _this.search.iDisplayStart=_this.search.iDisplayStart+1;
                _this.message = "加载中...";
                isLoading = true;
                var thisload;
                this.$nextTick(function () { thisload= layer.load();});
                ajaxCommon({
                    type: 'POST',
                    url: apiURL + '/product/getProductSpuList',
                    data: _this.search,
                    success: function (data) {
                        if (data.retCode == "0") {
                            if (data.data!=""&&null!=data.data&&data.data.spuList.length > 0) {
                                _this.companyOrderType=data.data.showPrice;//装饰公司是否可以购买
                                _this.showPrice= data.data.showPrice;//是否显示价格
                                _this.showPrePrice= data.data.showPrice;//显示优惠价
                                _this.message = "查看更多";
                                if(_this.prodList=="") {
                                    _this.prodList = data.data.spuList;
                                }else{
                                    _this.prodList=_this.prodList.concat(data.data.spuList);
                                }
//                                console.log(_this.prodList);
//                                sessionStorage.setItem("productList",_this.prodList);
                                if(data.data.spuList.length<_this.search.iDisplayLength){
                                    isComplete=true;
                                }
                            } else {
                                _this.isNextPage = 1;
                                _this.message = "没有更多了...";
                                isComplete=true;
                            }
                            isLoading = false;
                            _this.$nextTick(function () { myScroll.refresh();});

                        } else {
                            _this.message = "";
                        }

                        _this.$nextTick(function () { layer.close(thisload);});
                    }
                });
            }
        },
        searchProductByCondition1:function(){
            if(this.isGoBack==0) {//this.isShowClassifySear==1&&
//                $("#headerCategroy,.searchBox,.listBox").show();
//                $("#headerSearch").hide();
                this.isShowClassifySear=0;
                var prodname=this.search.productName;
                this.search.productName="";
                var newUrl = apiURL + "product/toProductSpuList?productName=" + prodname;
                window.location.href = newUrl;
            }else{
                var newUrl = apiURL + "product/toProductSpuList?productName=" + this.search.productName;
                history.replaceState({}, "", newUrl);
                window.location.href = newUrl;
            }
        },
        changeSearch:function(type){//搜索商品名称
/*            if(this.isShowClassifySear==0) {//显示搜索*/
            if(type==1){
               this.isShowClassifySear = 1;
//                $("#headerCategroy,.searchBox,.listBox").hide();
//                $("#headerSearch").show();
                this.isShowBigClassify = 0;
                this.isShowClassify = 0;
                this.isShowBrand=0;
                this.isShowMore=0;
            }else{
                if(this.isGoBack==1) {
                    history.back();
                }else{//隐藏搜索
                    this.isShowClassifySear = 0;
//                    $("#headerCategroy,.searchBox,.listBox").show();
//                    $("#headerSearch").hide();
                }
            }
        },
        classifySearch:function(cid){//根据分类id搜索分类下的商品数据
            $(".grade-eject>ul.grade-t>li").removeClass("on");
            $(".Sort-eject>ul>li").removeClass("on");
            $(event.currentTarget).addClass("on");
            this.search.brandId="";
            this.search.categoryId=cid;
            this.searchData();
            this.isShowClassify=0;
        },
        showClassifyTitle:function(){
            $("#hideContent li a").removeClass("on");
            var $selectC=$("#hideContent li a[cId="+this.categoryId+"]");
            $selectC.addClass("on");
            this.classifyName=$selectC.html();
        },
        showBigClassify:function(){//显示大分类
            this.isShowClassify=0;
            this.isShowBrand=0;
            this.isShowMore=0;
            if(this.isShowBigClassify==0) {
                if(this.bigClassify==null){
                  this.listBigClassify();
                }
                this.isShowBigClassify = 1;
            }else{
                this.isShowBigClassify = 0;
            }
        },
        listBigClassify:function(){//获取分类信息
            var _this = this;
            ajaxCommon({
                type: 'POST',
                url: apiURL + '/category/getCategoryLevelOne',
                data: {
                    key:1,
                    type:1,
                    uid:'${userId}'
                },
                async: false,
                success: function (data) {
                    if (data.retCode == 0) {
                        _this.bigClassify=data.category;
                    }
                }
            });
        },
        getProByTopCId:function(cId,cName){
//            var $this=$(event.currentTarget);
//            var newUrl=apiURL+"product/toProductSpuList?categoryId="+$this.attr("cId")+"&shopId="+$this.attr("shopId");
            var newUrl=apiURL+"product/toProductSpuList?categoryId="+cId+"&title="+cName;
            history.replaceState({}, "", newUrl);
            window.location.href=newUrl;
        },
        showClassify:function(){//显示分类
            this.isShowBigClassify = 0;
            this.isShowBrand=0;
            this.isShowMore=0;
            var _this=this;
            if(_this.isShowClassify==0) {
                if(_this.categoryList==''){
                    _this.categoryList =_this.listClassify();
                }
                _this.isShowClassify = 1;
            }else{
                _this.isShowClassify=0;
            }
        },
        showClassify2:function(cid){//2级分类显示
            var _this=this;
            _this.search.categoryId=cid;
            $(".grade-eject ul>li").removeClass("on");
            $(".Sort-eject ul>li").removeClass("on");
            $(event.currentTarget).addClass("on");
            $(".grade-t").addClass("on");
            /*if(_this.categorySecondList==''){
                _this.params.typeId=cid;
                _this.categoryList2=_this.listClassify();
                _this.categorySecondList=[{cateid:cid,secondList:_this.categoryList2}];
            }else{
                var ifhas=0;
                for(var i=0;i<_this.categorySecondList.length;i++){
                    if(_this.categorySecondList[i].cateid==cid){
                        _this.categoryList2=_this.categorySecondList[i].secondList;
                        ifhas=1;
                    }
                }
                if(ifhas==0){
                    _this.params.typeId=cid;
                    _this.categoryList2=_this.listClassify();
                    _this.categorySecondList.push({cateid:cid,secondList:_this.categoryList2});
                }
            }*/
            var ifhas=0;
            for(var i=0;i<_this.categoryList.length;i++){
                if(_this.categoryList[i].id==cid&&null!=_this.categoryList[i].children&&_this.categoryList[i].children.length>0){
                    _this.categoryList2=_this.categoryList[i].children;
                    ifhas=1;
                }
            }
            if(ifhas==0){
                _this.categoryList2=[];
            }
            if(_this.categoryList2.length<=0){
                _this.classifySearch(cid);
            }
        },
        listClassify:function(){//获取分类信息
            var _this = this;
            var resultData=null;
            ajaxCommon({
                type: 'POST',
                url: apiURL + '/category/getCategoryChildList',
                data: {
                    key:1,
                    type:1,
                    uid:'${userId}',
                    categoryId: _this.categoryId,
                    productName:_this.search.productName
                },
                async: false,
                success: function (data) {
                    if (data.retCode == 0) {
                        resultData=data.resultData;
                    }
                }
            });
            /*
            ajaxCommon({
                type: 'POST',
                url: apiURL + '/product/getChildrenTypes.do',
                data: {
                    key:1,
                    type:1,
                    uid:'${userId}',
                    params: JSON.stringify(_this.params)
                },
                async: false,
                success: function (data) {
                    if (data.success == true) {
                        resultData=data.data;
                    }
                }
            });*/
            return resultData;
        },
        brandSearch:function(bid){//根据品牌搜索商品
            $(".Sort-eject>ul>li").removeClass("on");
            $(event.currentTarget).addClass("on");
            this.search.brandId=bid;
            this.searchData();
            this.isShowBrand=0;
        },
        showBrand:function(){//显示品牌
            this.isShowBigClassify = 0;
            this.isShowClassify=0;
            this.isShowMore=0;
            var _this = this;

            if(this.isShowBrand==0) {
                this.isShowBrand = 1;
                if (_this.categoryBrandList == '') {
                    _this.brandList = _this.listBrand();
                    _this.categoryBrandList = [{cateid: _this.search.categoryId, brandList: _this.brandList}];
                } else {
                    var ifhas = 0;
                    for (var i = 0; i < _this.categoryBrandList.length; i++) {
                        if (_this.categoryBrandList[i].cateid == _this.search.categoryId) {
                            _this.brandList = _this.categoryBrandList[i].brandList;
                            ifhas = 1;
                        }
                    }
                    if (ifhas == 0) {
                        _this.brandList = this.listBrand();
                        _this.categoryBrandList.push({cateid: _this.search.categoryId, brandList: _this.brandList});
                    }
                }
            }else{
                this.isShowBrand = 0;
            }
        },
        listBrand:function(){//查询品牌信息
            var _this = this;
            var resultData=null;
            ajaxCommon({
                type: 'POST', url: apiURL + '/category/queryCateBrand',
                data: {
                    key:1,
                    type:1,
                    uid:'${userId}',
                    categoryId: _this.search.categoryId,
                    productName: _this.search.productName
                },
                async: false,
                success: function (data) {
                    if (data && data.brandList) {
                        resultData= data.brandList;
                    }
                }
            });
            return resultData;
        },
        saleSortFun:function(){//销量排序
            this.isShowBigClassify = 0;
            this.isShowClassify=0;
            this.isShowBrand=0;
            this.isShowMore=0;
            this.search.priceSort=0;
            if(this.search.saleSort==0){
                this.search.saleSort=1;
            }else if(this.search.saleSort==1){
                this.search.saleSort=2;
            }else{
                this.search.saleSort=0;
            }
            this.searchData();
        },
        priceSortFun:function(){//价格排序
            this.isShowBigClassify = 0;
            this.isShowClassify=0;
            this.isShowBrand=0;
            this.isShowMore=0;
            this.search.saleSort=0;
            if(this.search.priceSort==0){
                this.search.priceSort=1;
            }else if(this.search.priceSort==1){
                this.search.priceSort=2;
            }else{
                this.search.priceSort=0;
            }
            this.searchData();
        },
        showMore:function(){//是否显示更多的价格筛选项
            this.isShowBigClassify = 0;
            this.isShowClassify=0;
            this.isShowBrand=0;
            if(this.isShowMore==0) {
                this.isShowMore = 1;
            }else{
                this.isShowMore=0;
            }
        },
        priceSearch:function(type){//价格搜索和取消
            if(type==0){
                this.search.priceBegin="";
                this.search.priceEnd='';
            }else{
                if(this.search.priceBegin!=""||this.search.priceEnd!='') {
                    this.searchData();
                }
                this.isShowMore=0;
            }
        },
        toProductDetail:function(spu){//去详情页

           /* var prodid=spu.defProductId;
            if(""==spu.defProductId||null==spu.defProductId||"null"==spu.defProductId){
                prodid=spu.skuList[0].id;
            }*/
            var prodid=spu.skuList[0].id;;
        /*    $("html,body").attr("style","overflow:hidden");
            var h=document.documentElement.clientHeight-43;
            var strdiv="<div style=' width:100%; height:100%'>"
                    +'<header style="background-color:#d32d27; color:#fff;margin: 0 auto;"><a class="urlback-w" onclick="closeDetail()"></a>商品详情</header>';
            var frame= '<iframe src="'+apiURL+'/product/toProductSkuById?productId='+prodid+'" scroll="no" align="center" border="0" frameborder="0"  width="100%" height="'+h+'" ></iframe>';
            strdiv+=frame+"</div>";
            layer.open({
                type: 1
                ,content: strdiv
                ,anim: 'up'
                ,style: 'position:fixed; bottom:0; left:0; width: 100%; height: 100%; padding:0; border:none;'
                ,success:function(){

                }
            });*/
            window.location.href=apiURL+"/product/toProductSkuById?productId="+prodid;
        },
        addIntoShopcart:function(spu){//加入购物车弹层
            var skuList=spu.skuList;
            var shopId=spu.shopId;
            if(this.memType=='3'&&this.showPrice=='0'){
                this.$nextTick(function () {
                    goToBecomeMember();
                });
                return;
            }
            this.buyNum=1;
            this.isShowAdd=1;
//            console.log(skuList);
//            $("html,body").attr("style","overflow:hidden");

//            skuList=outerskulist;
            this.selectProd=skuList[0];
            this.selectProdShop=shopId;
            var spuProd={};
            var firstSaleAttr=this.selectProd.saleAttrList;
            if(null==firstSaleAttr||""==firstSaleAttr||firstSaleAttr.length<=0) {
                //如果第一个商品没有属性 则才spu的所有商品没有属性，展示第一个商品的数据信息
                spuProd=this.selectProd;
            }else{
                spuProd = {
                    id: spu.id,
                    productName: spu.assembleName,
                    productPic: spu.itemPicUrl,
                    originalPrice: 0,
                    promoteSale: spu.displayPrice,
                    stock: spu.stock
                };
            }

            this.defProd=spuProd;

            this.selectSpu={};//map
            var newSkuList={};//map
            var attrList=[];//用于展示属性排列
            var attrIds=[];
            var attrValues={};//map

            /*
            * 拼装数组A     以供展示属性选项     格式是
            *   属性名称id,属性名称(颜色),{属性值id,属性值，此属性值所属商品id}
            *   举例子
            *   颜色： 蓝色 红色 黄色
            *   规格： v10 v12 v14
            *   套餐：套餐1 套餐2 套餐3
            *
            * 和
            *
            * 拼装数组B 格式是
            *   第一组属性值,{第二组属性值1,第二组属性值2，第三组属性值2...}
            *   举例子
            *   蓝色： S M 套餐一
            *   红色： S M
            *   黄色： S     套餐一
            *   S: 蓝色 红色 黄色
            *   M: 蓝色 红色
            *   套餐一: 蓝色      黄色
            * */
            for(var i=0;i<skuList.length;i++){
                //选择的商品list重构
                newSkuList[skuList[i].id]=skuList[i];
                var saleAttrList=skuList[i].saleAttrList;
                if(null!=saleAttrList&&""!=saleAttrList) {
                    for (var j = 0; j < saleAttrList.length; j++) {
                        var saleAttr = saleAttrList[j];
                        var attrId = saleAttr.attrId;
                        var valId = saleAttr.attrValueId;
                        var valObj={
                            attrValueId: saleAttr.attrValueId,
                            attrValue: saleAttr.attrValue,
                            prodId: [skuList[i].id],
                            isDisable: false,
                            isSelected:false
                        };
                        //--- 拼装数组A begin ------------------------------
                        var idIndex = attrIds.indexOf(attrId);
                        if (idIndex > -1) {
                            var vIndex = attrValues[attrId].indexOf(valId);
                            if (vIndex > -1) {
                                attrList[idIndex].valueList[vIndex].prodId.push(skuList[i].id);
                            } else {
                                attrValues[attrId].push(valId);
                                attrList[idIndex].valueList.push(valObj);
                            }
                        } else {
                            attrIds.push(attrId);
                            attrValues[attrId] = [valId];
                            attrList.push({
                                attrId: attrId,
                                attrName: saleAttr.attrName,
                                valueList: [valObj]
                            });
                        }
                        if(skuList[i].id==this.selectProd.id) {
                            this.selectAttrList[attrId] = valObj;
                        }
                        //--- 拼装数组A end ------------------------------
                        /*  if(!changeSaleAttr1[valId]) {
                        changeSaleAttr1[valId]=[];
                    }
                    var attrLen=saleAttrList.length;
                    for (var k = 0; k < attrLen; k++) {
                        var saleAttr2 = saleAttrList[k];
                        if(changeSaleAttr1[valId].indexOf(saleAttr2.attrValueId)==-1) {
                            changeSaleAttr1[valId].push(saleAttr2.attrValueId);
                            changeSaleAttr1[valId].push(saleAttr2.attrValue);
                        }
                    }*/
                    }
                }
            }
//            console.log(this.selectAttrList);
            this.selectSpu=newSkuList;
            this.selectAttrGroup=attrList;//赋值展示属性数组

            /*
             * 拼装数组B    以供选择后置灰部分选项   格式是
             *   第一组属性值,{第二组属性值1,第二组属性值2，第三组属性值2...}
             *   举例子
             *   蓝色： S M 套餐一
             *   红色： S M
             *   黄色： S     套餐一
             *   S: 蓝色 红色 黄色
             *   M: 蓝色 红色
             *   套餐一: 蓝色      黄色
             * */
            var changeSaleAttr1=[];//格式 蓝色：S M 套餐一 套餐二  用于判断属性是否高亮
            for(var i=0;i<skuList.length;i++){
                var saleAttrList=skuList[i].saleAttrList;
                if(null!=saleAttrList&&""!=saleAttrList) {
                    var attrLen = saleAttrList.length;
                    for (var j = 0; j < attrLen; j++) {
                        var saleAttr = saleAttrList[j];
                        var valId = saleAttr.attrValueId;
                        if (!changeSaleAttr1[valId]) {
                            changeSaleAttr1[valId] = [];
                        }
                        for (var k = 0; k < attrLen; k++) {
                            var saleAttr2 = saleAttrList[k];
                            if (changeSaleAttr1[valId].indexOf(saleAttr2.attrValueId) == -1) {
                                changeSaleAttr1[valId].push(saleAttr2.attrValueId);
                                changeSaleAttr1[valId].push(saleAttr2.attrValue);
                            }
                        }
                    }
                }
            }
            this.changeSaleAttr=changeSaleAttr1;//拼装的数组 以供选择后置灰部分选项

            this.changeAttrStyle();
           /* this.$nextTick(function(){
                var myScroll2 = new IScroll('#wrapper2', {
                    probeType: 3,
                    scrollbars: true,
                    mouseWheel: true,
                    click:true, // 使子元素可点击
                    interactiveScrollbars: true,
                    shrinkScrollbars: 'scale',
                    fadeScrollbars: true
                });
            });*/


            this.$nextTick(function () {
                simpScroller(document.querySelector(".scrollbox"),{hideScrollBar:1});
                /*if (/(Android)/i.test(navigator.userAgent)) {
                    $(window).resize(function () {
                        var $choosed = $(".choosedetail");
                        if ($(window).height() < wh) {
                            if (!$choosed.hasClass("on")) {
                                $choosed.addClass("on");
                            }
                        } else {
                            if ($choosed.hasClass("on")) {
                                $choosed.removeClass("on");
                            }
                        }
                    });
                }*/
                 /* if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
                    $('.number-choose input').on('click', function () {
                        var target = this;
                        // 使用定时器是为了让输入框上滑时更加自然
                        setTimeout(function(){
                              target.scrollIntoView(true);
                            },100);
                    });
                }*/
            });
        },
        closeAdd:function(){//关闭加入购物车弹层
            this.buyNum=1;
            this.isShowAdd=0;
            this.selectProdShop='';
            this.selectSpu='';
            this.selectProd='';
            this.selectAttrGroup=[];//页面显示的属性数组
            this.selectAttrList=[];//置空已经选中的商品属性

//            $("html,body,.listBox").removeAttr("style");
           /* document.body.addEventListener('touchmove', function (e) {
                e.returnValue = true;
            }, false);*/
//            this.$nextTick(function () {
//                $(window).off("resize");
//                $('.number-choose input').off('click');
//            });
        },
        fillChangeBuyNum:function(ctype){//输入改变购买个数
//            this.$nextTick(function () {
////                if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)) {
//                    var $choosed = $(".choosedetail");
//                    if (ctype == -1) {
//                        if (!$choosed.hasClass("on")) {
//                            $choosed.addClass("on");
//                        }
//                        interval=setInterval(function(){
//                            if($(".number-choose input").is(":focus")){
//                                if (!$choosed.hasClass("on")) {
//                                    $choosed.addClass("on");
//                                }
//                            }else{
//                                $choosed.removeClass("on");
//                            }
//                        },100);
//                    } else if (ctype == 1) {
//                        if ($choosed.hasClass("on")) {
//                            $choosed.removeClass("on");
//                        }
//                        clearInterval(interval);
//                    }
//                   /* $('.number-choose input').on('keypress', function(evt){ //#txt是个text input
//                        alert(evt.keyCode);
//                });*/
////                }
//            });
            if(ctype!=-1) {
                if (this.buyNum >= 0) {
                    if (/^0/.test(this.buyNum)) {
                        this.buyNum = parseInt(this.buyNum);
                    }
                    //                if(this.buyNum.indexOf(".")>-1){
                    //                    this.buyNum = this.buyNum.replace(/\D/g, '');
                    //                }
                } else {
                    this.buyNum = this.buyNum.replace(/\D/g, '');
                    if (this.buyNum == '') {
                        if (ctype == 1) {
                            this.buyNum = 1;
                        }
                    }
                }
                if (this.buyNum > 1) {
                    $(".decrease").removeClass("disabled");
                } else {
                    if (ctype == 1 || this.buyNum != "") {
                        this.buyNum = 1;
                    }
                    $(".decrease").addClass("disabled");
                }
                if (this.buyNum < this.selectProd.stock) {
                    $(".addnum").removeClass("disabled");
                } else {
                    if (ctype == 1 || this.buyNum != "") {
                        this.buyNum = this.selectProd.stock;
                        /*this.$nextTick(function () {
                         layer.msg("数量超出库存");
                         });*/
                    }
                    $(".addnum").addClass("disabled");
                }
            }
        },
        clickChangeBuyNum:function(type){//点击改变购买个数
/*
            var ua = window.navigator.userAgent.toLowerCase();
            if(!/macintosh|window/.test(ua)||ua.match(/MicroMessenger/i) == 'micromessenger'||/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)||/(Android)/i.test(navigator.userAgent)){
                return ;
            }else{
//               */
                this.changeBuyNum(type);
            /*}*/
        },
        touchChangeBuyNum:function(type){//点击改变购买个数
//            alert(3);
            //加减速度修改
            var ua = window.navigator.userAgent.toLowerCase();
            if(ua.match(/MicroMessenger/i) == 'micromessenger'||/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)||/(Android)/i.test(navigator.userAgent)){
                this.changeBuyNum(type);
                event.preventDefault();
            }else{
//                alert(5);
                return;
            }
        },
        changeBuyNum:function(type){//点击改变购买个数
            /*var $choosed=$(".choosedetail");
             if($choosed.hasClass("on")){
             $choosed.removeClass("on");
             }*/
            /*$(".number-choose").find("input").focus();*/
            if(!$(event.currentTarget).hasClass("disabled")) {
                if (type == 0) {
                    if (this.buyNum > 1) {
                        this.buyNum = parseInt(this.buyNum) - 1;
                    }
                } else {
                    if (this.buyNum < this.selectProd.stock) {
                        this.buyNum = parseInt(this.buyNum) + 1;
                    }
                }
                if (this.buyNum > 1) {
                    $(".decrease").removeClass("disabled");
                }else{
                    $(".decrease").addClass("disabled");
                }
                if (this.buyNum < this.selectProd.stock) {
                    $(".addnum").removeClass("disabled");
                }else{
                    $(".addnum").addClass("disabled");
                }
            }
        },
        selectAttr:function(attrId,attrValues,isdisable){//选择属性操作
            if(!isdisable) {
                var _target=$(event.currentTarget);
                if (_target.hasClass("on")) {
                    delete this.selectAttrList[attrId];
                } else {
                    this.selectAttrList[attrId] = attrValues;
                }
                this.changeAttrStyle();
            }
        },
        changeAttrStyle:function(){//修改属性的样式
            /*//将所有属性高亮  选中的项为选中状态 未选中的状态恢复未选中状态*/
            for (var i = 0; i < this.selectAttrGroup.length; i++) {
                var attrId=this.selectAttrGroup[i].attrId;
                var attrValueId="";
                if(this.selectAttrList[attrId]){
                    attrValueId=this.selectAttrList[attrId].attrValueId;
                }
                var valueList = this.selectAttrGroup[i].valueList;
                for (var j = 0; j < valueList.length; j++) {
                    valueList[j].isDisable = false;
                    if(attrValueId!=""&&valueList[j].attrValueId==attrValueId){
                        valueList[j].isSelected = true;
                    }else{
                        valueList[j].isSelected = false;
                    }
                }
            }

            //如果选择了部分属性，要判断其他属性是否高亮
            //选中商品属性 可与之搭配的其他属性 高亮
            for (var key in this.selectAttrList) {
                var crossAttr = [];
                var valId = this.selectAttrList[key].attrValueId;
                crossAttr = this.changeSaleAttr[valId];
                for (var i = 0; i < this.selectAttrGroup.length; i++) {
                    if (this.selectAttrGroup[i].attrId != key) {
                        var valueList = this.selectAttrGroup[i].valueList;
                        for (var j = 0; j < valueList.length; j++) {
                            if (!valueList[j].isDisable) {
                                if (crossAttr.indexOf(valueList[j].attrValueId) == -1) {
                                    valueList[j].isDisable = true;
                                }
                            }
                        }
                    }
                }
            }

            //属性选择后，页面上显示的商品信息
            var mayProductList = [];
            for (var key in this.selectAttrList) {
                var valueList = this.selectAttrList[key];
                if (mayProductList.length > 0) {
                    mayProductList = mayProductList.filter(function (x) {
                        return valueList.prodId.indexOf(x) > -1;
                    });
                } else {
                    mayProductList = valueList.prodId;
                }
            }
//                console.log(mayProductList);
            if (mayProductList.length > 0) {
                this.selectProd = this.selectSpu[mayProductList[0]];
            } else {
                this.selectProd = this.defProd;
            }
            this.buyNum=1;
            if(this.buyNum<1&&this.selectProd.stock>0) {
                this.buyNum=1;
            }
            if(this.buyNum>this.selectProd.stock){
                this.buyNum=this.selectProd.stock;
            }
            if (this.buyNum > 1) {
                $(".decrease").removeClass("disabled");
            }else{
                $(".decrease").addClass("disabled");
            }
            if (this.buyNum < this.selectProd.stock) {
                $(".addnum").removeClass("disabled");
            }else{
                $(".addnum").addClass("disabled");
            }
        },
        addToShopCart:function(){//商品加入购物车
            /*if(this.memType=="1"&&this.companyOrderType=="0"){
                return ;
            }else {*/
            if(this.isCanbuy==1){
                this.isCanbuy=0;
                if (Object.keys(this.selectAttrList).length == this.selectAttrGroup.length) {
//                    console.log(this.selectProd);
                    var _this=this;
                    ajaxCommon({
                        type: 'POST',
                        url: apiURL + '/cart/addShopCart',
                        dataType: "json",
                        data: {
                            key:1,
                            type:'${type}',
                            uid:'${userId}',
                            mid: this.selectProdShop,
                            productId: this.selectProd.id,
                            num: this.buyNum,
                            activityId: this.selectProd.activityId == "null" ? '' : this.selectProd.activityId
                        },
                        async: false,
                        success: function (response) {
                            if (response.result==1) {
                                layer.msg("加入成功");
                            }else{
                                layer.msg("加入失败");
                            }
                            _this.isCanbuy=1;
                        },
                        error:function(){
                            _this.isCanbuy=1;
                        }
                    });
                }else{
                    layer.msg("请选择商品");
                    this.isCanbuy=1;
                }
            }
            /*}*/
        },
        gotoShopCart:function(){
            window.location.href=apiURL+"/cart/toShopCart";
        },
        collectProd:function() {
            if (Object.keys(this.selectAttrList).length == this.selectAttrGroup.length) {
                var _this=this;
                if(this.selectProd.isCollect==0&&this.selectProd.isActivity==0) {
                    var params = new Object();
                    params.productArray=[this.selectProd.id];
                    ajaxCommon({
                        type: 'POST',
                        url: apiURL + '/cart/addCartCollecion',
                        data: {
                            key:1,
                            type:1,
                            uid:'${userId}',
                            params: JSON.stringify(params)
                        },
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.success == true) {
    //                            layer.msg("收藏成功");
                                _this.selectProd.isCollect=1;
                            } else {
                                layer.msg("收藏失败");
                            }
                        },
                        error: function () {
                            layer.msg("网络繁忙，请稍后再试");
                        }
                    });
                }else{
                    if(this.selectProd.isActivity==1){
                        layer.msg("活动商品不能收藏");
                    }else{
                        ajaxCommon({
                            url:apiURL+'/collect/cancelCollect',
                            data:{key:1,type:'${type}',uid:'${userId}',targetId:_this.selectProd.id},
                            success:function(map){
                                if(map.retCode==0) {
                                    //layer.msg("取消收藏成功");
                                    _this.selectProd.isCollect = 0;
                                }else{
                                    layer.msg(map.retDesc);
                                }
                            }
                        });
                    }
                }
            }else{
                layer.msg("请选择商品");
            }
        },
        getQueryString:function (name) {//得到query
            var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
            var r = window.location.search.substr(1).match(reg);
            if (r != null) {
                return r[2];
//                return unescape(r[2]);
            }
            return null;
        },
        getHashString:function (name) {//得到hash
            var reg = new RegExp('(^|#)' + name + '=([^#]*)(#|$)', 'i');
            var r = window.location.hash.substr(1).match(reg);
//            console.log(r);
            if (r != null) {
                return r[2];
//                return unescape(r[2]);
            }
            return null;
        }
    }
})

function closeDetail(){//关闭详情页弹层
    $("html,body").removeAttr("style");
    layer.closeAll();
}

</script>
<div class="tip" style="display:none">
    <div class="tip-content">成为会员  即可购买哦</div>
    <div class="tip-btn">
        <a class="tip-btn1" href="javascript:void(0);">加入会员</a>
    </div>
    <div class="tip_close"></div>
</div>
<script>
    /**
     * 去成为会员
     * */
    function goToBecomeMember(){
        TipTool.tip(null, function () {
            window.location.href = SITE_BASE_PATH + 'sfjMember/ToBecomeMember';
        });
    }
</script>


<!--定位分站-->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    //地址头
    var posiInit={rootUrl:'<%=request.getContextPath()%>/',userId:'${userId}',showSelect:1 };
    $(function(){
        initAndshowSite(function(){
            myvue.initList();
        });
    })
</script>
<script type="text/javascript" src="<c:url value="/resources/js/position.js" />"></script>
<div style="display: none"><script src="<c:url value='/resources/cnzz.js'/>"></script></div>
</body>
</html>
