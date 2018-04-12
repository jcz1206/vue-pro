<template>
    <div class="o-skupop-btm show" v-if="selectProd!=null">
      <div>
        <div class="pop-blank"></div>
        <div class="pop-main hide">
          <div class="ctrl-ui-sku">
            <div class="sku-pro">
              <div>
                <div class="sku-img">
                  <p><img v-lazy="selectProd.img"></p>
                </div>
                <div class="sku-pro-info">
                  <div>
                    <h3 class="sku-title">{|{selectProd.name}}</h3>
                    <p class="h">￥{|{selectProd.salePrice}}</p><p class="quantity">库存:{|{selectProd.stock}}</p>
                    <p class="sku-txt"><span class="c-sku"></span><span class="unc-sku">请选择: 尺码 颜色分类</span></p>
                  </div>
                </div>
                <div class="sku-closed" @click="closeSelect"></div>
              </div>
            </div>
            <div class="sku-info">
              <div>
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
              </div>
              <div class="quantity-info">
                <div class="sku-quantity">
                  <h2>购买数量 <span></span></h2><p class="btn-minus off"><a class="btn minus" min=""></a></p>
                  <p class="btn-input"><input type="tel" value="1"></p>
                  <p class="btn-plus"><a class="btn plus" max=""></a></p>
                </div>
              </div>
            </div>                  
            <div>
              <div class="sku-btns">
                <div class="sku-btn addcart">加入购物车</div>
                <div class="sku-btn gobuy">立即购买</div>
              </div>
            </div>
          </div>
      </div>
    </div>
  </div>
</template>
<!--
<style  lang="scss" scoped rel="stylesheet/scss">
//这样引入的话，css内图片的路径要写这个component的相对路径
@import '../../assets/css/product/category.scss';
</style>
-->
<script>
import '../../assets/css/product/category.scss';
//这样引入的话，css内图片的路径要写css的相对路径即可
export default {
  name:"addcart",
  props:["selectSpu"],
  data(){
      return {         
              selectProd:null,
              defProd:null,
              selectSpu:{},
              selectAttrGroup:null,
              changeSaleAttr:null
      }
  },
  created:function(){
    this.showProd();
  },
  methods:{
        onClickMe: function(id){
          $(event.currentTarget).addClass("on").siblings("a").removeClass("on");
          this.$parent.cateid=id;
          this.$parent.getProductlist(id);
          // console.log(this.$parent);  //访问根组件  
          // console.log(this.$parent.cateid);  //访问根组件的cateid属性  
          // this.$emit('child-say',id);
        },
        closeSelect:function(){
          this.$parent.selectedProd=null;
        },
        showProd:function(){ 
           var spu=this.selectSpu;    
            var skuList=spu.sku; 
            
            // this.buyNum=1; 
            this.selectProd=skuList[0]; 
            var spuProd={};
            var firstSaleAttr=this.selectProd.saleAttrList;
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
                    stock: 0//spu.stock
                };
            }

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

            // this.changeAttrStyle();
        }
  }
}
</script>

<style scoped>
</style>
