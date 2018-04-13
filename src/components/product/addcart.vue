<template>
    <div class="o-skupop-btm show" v-if="selectProd!=null">
      <div>
        <div class="pop-blank" @click="closeSelect"></div>
        <div class="pop-main hide">
          <div class="ctrl-ui-sku">
            <div class="sku-pro">
              <div>
                <div class="sku-img">
                  <p><img v-lazy="selectProd.img"></p>
                </div>
                <div class="sku-pro-info">
                  <div>
                    <h3 class="sku-title">{{selectProd.name}}</h3>
                    <p class="h">￥{{selectProd.salePrice}}</p><p class="quantity">库存:{{selectProd.stock}}</p>
                    <p class="sku-txt"><span class="c-sku"></span><span class="unc-sku">请选择: 尺码 颜色分类</span></p>
                  </div>
                </div>
                <div class="sku-closed" @click="closeSelect"></div>
              </div>
            </div>
            <div class="sku-info">
                <div v-for="item in selectAttrGroup" v-if="selectAttrGroup!=null">
                    <h2>{{item.attrName}}</h2>
                    <ul>
                        <li v-for="item2 in item.valueList" 
                         class="normal" 
                          @click="selectAttr(item.attrId,item2,item2.isDisable)" 
                          v-bind:class="{'disabled':item2.isDisable,'on':item2.isSelected}">
                          <a>{{item2.attrValue}}</a></li>
                    </ul>
                </div>
              <!-- <div>
                <h2>尺码</h2>
                <ul>
                  <li class="normal">S 【现货】</li>
                  <li class="normal">M 【现货】</li>
                  <li class="normal">L 【现货】</li>
                  <li class="normal">XL 【现货】</li>
                  <li class="normal">2XL 【现货】</li>
                </ul>
              </div>
              <div>
                  <h2>颜色分类</h2>
                  <ul>
                    <li class="normal">粉色</li>
                    <li class="normal">驼色</li>
                  </ul>
              </div> -->
              <div class="quantity-info">
                <div class="sku-quantity">
                  <h2>购买数量 <span></span></h2>
                  <p class="btn-minus" :class="{'off':isoffm===0}"  @click="clickChangeBuyNum(0)"><a class="btn minus" min=""></a></p>
                  <p class="btn-input"><input type="tel" v-model="buyNum" @blur="checkBuyNum()"></p>
                  <p class="btn-plus"  :class="{'off':isoffp===0}" @click="clickChangeBuyNum(1)"><a class="btn plus" max=""></a></p>
                </div>
              </div>
            </div>                  
            <div>
              <div class="sku-btns">
                <div class="sku-btn addcart" @click="addCartAction" :class="{'off':selectProd.stock<=0}">加入购物车</div>
                <div class="sku-btn gobuy" :class="{'off':selectProd.stock<=0}">立即购买</div>
              </div>
            </div>
          </div>
      </div>
    </div>
  </div>
</template>
<script>

import { mapGetters } from 'vuex'
export default {
  name:"addcart",
  props:["selectedSpu"],
  data(){
      return {         
              selectProd:null,//将要加入购物车的商品仅用于页面展示
              defProd:null,//没有选择任何商品时，页面展示的商品数据信息(弹层中展示的数据)
              selectSpu:{},//将要加入购物车的产品 重构后的map接口 key是productid
              selectAttrGroup:null,//选择商品属性 仅用于展示数据
              changeSaleAttr:null,//选择商品属性 用于判断去灰化哪些不能选择的属性值
              selectAttrList:[],//选中的销售属性列表
              buyNum:1, //加入购物车的个数
              isoffm:0,//购买的数量 0不能减 1能减
              isoffp:1,//购买的数量 0不能加 1能加
      }
  },
  created:function(){
    this.showProd();
  },
//   computed:{
//       ...mapGetters:{

//       }
//   }
  methods:{
        closeSelect:function(){
          this.$parent.selectedProd=null;
        },
        showProd:function(){ 
           var spu=this.selectedSpu;    
            var skuList=spu.sku; 
            
            this.buyNum=1; 
            var spuProd={};
            // this.selectProd=skuList[0]; 
            // var firstSaleAttr=this.selectProd.saleAttr;
            var firstSaleAttr=skuList[0].saleAttr;
            if(null==firstSaleAttr||""==firstSaleAttr||firstSaleAttr.length<=0) {
                //如果第一个商品没有属性 则才spu的所有商品没有属性，展示第一个商品的数据信息
                spuProd=this.selectProd;
            }else{
                spuProd = {
                    id: spu.id,
                    name: spu.spuname,
                    img: spu.img,
                    originalPrice: 0,
                    salePrice: spu.sku[0].salePrice,
                    stock: spu.stock
                };
            }
            this.selectProd=spuProd;
            this.defProd=spuProd;

            // this.selectSpu={};//map
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
                var saleAttrList=skuList[i].saleAttr;
                if(null!=saleAttrList&&""!=saleAttrList) { 
                    for (var j = 0; j < saleAttrList.length; j++) {
                        var saleAttr = saleAttrList[j];
                        var attrId = saleAttr.attrId;
                        var valId = saleAttr.attrVId;
                        var valObj={
                            attrValueId: saleAttr.attrVId,
                            attrValue: saleAttr.attrVv,
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
                    }
                }
            }
            
            this.selectSpu=newSkuList;
            this.selectAttrGroup=attrList;//赋值展示属性数组
            

            // console.log(attrList);
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
                var saleAttrList=skuList[i].saleAttr;
                if(null!=saleAttrList&&""!=saleAttrList) {
                    var attrLen = saleAttrList.length;
                    for (var j = 0; j < attrLen; j++) {
                        var saleAttr = saleAttrList[j];
                        var valId = saleAttr.attrVId;
                        if (!changeSaleAttr1[valId]) {
                            changeSaleAttr1[valId] = [];
                        }
                        for (var k = 0; k < attrLen; k++) {
                            var saleAttr2 = saleAttrList[k];
                            if (changeSaleAttr1[valId].indexOf(saleAttr2.attrVId) == -1) {
                                changeSaleAttr1[valId].push(saleAttr2.attrVId);
                                changeSaleAttr1[valId].push(saleAttr2.attrVv);
                            }
                        }
                    }
                }
            }
            this.changeSaleAttr=changeSaleAttr1;//拼装的数组 以供选择后置灰部分选项
            // this.changeAttrStyle();
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
        changeAttrStyle:function(){
            //修改属性的样式
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
            this.checkBuyNum();
        },
        checkBuyNum:function(){
            if(this.buyNum<1&&this.selectProd.stock>0) {
                this.buyNum=1;
            }
            if(this.buyNum>this.selectProd.stock){
                this.buyNum=this.selectProd.stock;
            }
            this.changeBtnStyle();
        },
        clickChangeBuyNum:function(type){//点击改变购买个数 
            this.changeBuyNum(type); 
        },
        touchChangeBuyNum:function(type){//点击改变购买个数
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
            // if(!$(event.currentTarget).hasClass("off")) {
                if (type == 0&&this.isoffm==1) {
                    if (this.buyNum > 1) {
                        this.buyNum = parseInt(this.buyNum) - 1;
                    }
                this.changeBtnStyle();
                } else if(this.isoffp==1){
                    if (this.buyNum < this.selectProd.stock) {
                        this.buyNum = parseInt(this.buyNum) + 1;
                    }
                this.changeBtnStyle();
                }
            // }
        },
        changeBtnStyle:function(){
                if (this.buyNum > 1) {
                    this.isoffm=1;
                    // $(".btn-minus").removeClass("off");
                }else{
                    this.isoffm=0;
                    // $(".btn-minus").addClass("off");
                }
                if (this.buyNum < this.selectProd.stock) {
                    this.isoffp=1;
                    // $(".btn-plus").removeClass("off");
                }else{
                    this.isoffp=0;
                    // $(".btn-plus").addClass("off");
                }
        },
        addCartAction:function(){
            if(this.selectProd.stock>0){
                if (Object.keys(this.selectAttrList).length == this.selectAttrGroup.length) {
                    this.$store.dispatch('cartadd', this.selectProd);
                    
                    // console.log(this.$store.state.cart)
                    layer.open({
                        content: '添加成功!'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                    });
                }else{
                    // layer.msg("请选择商品");
                    layer.open({
                        content: '请选择商品!'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                    });
                }
            }

        }
  }
}
</script>

<style scoped>
</style>
