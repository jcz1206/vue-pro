<template>
<div>
  <div>Vuex临时存储,仅学习vuex</div>
    <div class="prodlist">
        <div v-for="item in productlist" @key="item.id" >
          
            <div class="ft-cb o-t-item" >
              <p >
                
                  <input :id="'cb-'+item.id"  type="checkbox" class="cb o-t-cb">
                <label :for="'cb-'+item.id" >
                </label>
              </p>
            </div>
            <div class="prodimg">
                <img v-lazy="item.img"/>
            </div>
            <div class="prodcon">
                <div class="prodname">{{item.name}}</div>
                <!-- <div class="prodname">guige</div> -->
                <div class="prodbottom">
                    <div class="prodnumber">
                        <div class="prodprice">￥{{item.salePrice}}</div>
                        <div class="prodstock">库存：{{item.stock}}</div>
                        <!-- {{item|sumStock}}| -->
                    </div>
                    <!-- <div class="prodcart" @click="addCart(item)"><i class="icon iconfont icon-gouwuchetianjia"></i></div> -->
                    <div class="prodcart ctrl-ui-sku">
                      <div class="sku-quantity">
                        <p class="btn-minus" :class="{'off':isoffm===0}"  @click="clickChangeBuyNum(0)"><a class="btn minus" min=""></a></p>
                        <p class="btn-input"><input type="tel" value="1" @blur="checkBuyNum()"></p>
                        <p class="btn-plus"  :class="{'off':isoffp===0}" @click="clickChangeBuyNum(1)"><a class="btn plus" max=""></a></p>
                      </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="productlist.length==0">
            <router-link to="productlist/c003">暂无商品，去商品选择商品吧</router-link>
        </div>
    </div>
    
        <div class="cartbuy">
            <div class="footer" >
              <div class="f-fx" >
                <div>
                  <div class="ft-cb" >
                    <p >
                      <input id="cb-footer" type="checkbox" class="cb o-t-cb">
                      <label for="cb-footer" ></label>
                    </p>
                  </div>
                  <div class="qx" >全选</div>
                  <div class="pay" >
                    <div >
                      <div  >
                        <span class="hj" >合计：</span>
                        <p class="o-t-price" data-symbol="￥" >
                          <span >
                            <span class="major" >0</span>
                            <span class="point" >.</span>
                            <span class="minor" >00</span>
                          </span>
                        </p>
                      </div>
                      <p></p>
                    </div>
                  </div>
                  <div class="btn" >
                    <p>
                      <span>结算</span>
                      <span>(</span>
                      <span>0</span>
                      <span>)</span>
                    </p>
                  </div>
                </div>
              </div>
            </div>
            </div>
        <footbar></footbar>
</div>
</template>
<style scoped lang="scss">
.prodlist .prodnumber,.prodlist .prodcart{ width:50%;}
.prodlist {
    margin-bottom:60px;
}

.prodlist .prodimg{
    width: 2rem;
    height: 2rem;
}
.prodlist .ft-cb{
  width:.8rem;
  text-align: center;
  padding-top: .3rem;
  height: 1.2rem;
}
.prodlist .prodcon {
    width: -webkit-calc(100% - 2.8rem);
    width: -moz-calc(100% - 2.8rem);
    width: calc(100% - 2.8rem);
}
.prodlist .o-t-cb + label:after {
    height:1.2rem;
}
</style>
<script>
import { mapGetters } from 'vuex'
import footbar from "@/components/footbar.vue";
import "@/assets/css/product/cart.scss"
export default{
    name:"cartlist",
    components:{
      footbar
    },
    data(){
        return {
            data:null,
            cateid:this.$route.params.cid,
            productlist:[],
            selectedProd:null
        }
    },
    filters:{
        sumStock:(spu)=>{
            let skulist=spu.sku;
            let stock=0;
            skulist.forEach((sku)=>{
                stock+=sku.stock;
            })
            return stock;
        }
    },
    created:function(){
      this.productlist=this.$store.state.cart;
      console.log(this.productlist);
    },
    mounted:function(){   
      // console.log(this.$store.state.cart);
        // document.querySelector('.nav2 a').dispatchEvent(new Event('click'));
        // console.log(this.$route.params.cid);
        // this.getProductlist(this.cateid);
    },
    methods:{
        addCart:function(spu){
            this.selectedProd=spu;
            // this.data=2;
        },
        listenToMyBoy: cateid=>{
            // console.log(cateid+"====");
            // this.cateid=cateid;
            // this.getProductlist(cateid);
        },
        getProductlist:function(cateid){

            // console.log(this.cateid);            
            // this.$http.get("/static/json/products.json").then(
            //     response => {
            //         this.data = response.data;
                    this.productlist=[];
                    let prodlist=productlistData;
                    //response.data

                    prodlist.forEach((spu)=>{
                        if(spu.cateid.indexOf(cateid)==0){
                            let skulist=spu.sku;
                            // console.log(skulist);
                            let totalstock=skulist.reduce((previousValue=0, currentValue,index) => { 
                                // if(typeof previousValue=="object"){
                                if(index==1){
                                    return previousValue.stock + currentValue.stock;
                                }else{
                                    return previousValue + currentValue.stock;
                                }
                            });
                            spu.stock=totalstock;
                            this.productlist.push(spu);
                        }
                    });
            //     },
            //     response => {
            //     // 响应错误回调
            //     alert("服务器请求失败");
            //     }
            // );
        }
    }
}

            var productlistData=[
                {
                    "spuid": "c001001",
                    "spuname": "金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管金牛水管",
                    "cateid": "c001",
                    "img":"https://jcz1206.github.io/static/prod/1.jpg",
                    "sku": [{
                        "id": "c001001p001001",
                        "name": "水管哦1",
                        "img": "https://jcz1206.github.io/static/prod/3.jpg",
                        "originPrice": "20.00",
                        "salePrice": "16.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "黄色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002001",
                            "attrVv": "S"
                        }]
                    }, {
                        "id": "c001001p001002",
                        "name": "水管哦2",
                        "img": "https://jcz1206.github.io/static/prod/1.jpg",
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "黄色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002002",
                            "attrVv": "M"
                        }]
                    }]
                }, {
                    "spuid": "c002001",
                    "spuname": "电线",
                    "cateid": "c002",
                    "img":"",
                    "sku": [{
                        "id": "c002001p001001",
                        "name": "电线哦1",
                        "img": "",
                        "originPrice": "20.00",
                        "salePrice": "16.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "黄色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002001",
                            "attrVv": "S"
                        }]
                    }, {
                        "id": "c002001p001002",
                        "name": "电线哦2",
                        "img": "",
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "黄色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002002",
                            "attrVv": "M"
                        }]
                    }]
                }, {
                    "spuid": "c003001",
                    "spuname": "可耐福纸面石膏板",
                    "cateid": "c003001",
                    "img": "https://jcz1206.github.io/static/prod/60000036.png",
                    "sku": [{
                        "id": "c003001p001001",
                        "name": "可耐福纸面石膏板1111111",
                        "img": "https://jcz1206.github.io/static/prod/60000036.png",
                        "originPrice": "20.00",
                        "salePrice": "16.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002001",
                            "attrVv": "20cm"
                        }]
                    }, {
                        "id": "c003001p001002",
                        "name": "光大之星E1级奥松板222222",
                        "img":'https://jcz1206.github.io/static/prod/10.jpg',
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 0,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001002",
                            "attrVv": "棕色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002002",
                            "attrVv": "10cm"
                        }]
                    }, {
                        "id": "c003001p001003",
                        "name": "光大之星E1级奥松板33333333",
                        "img":'https://jcz1206.github.io/static/prod/10.jpg',
                        "originPrice": "25.00",
                        "salePrice": "19.00",
                        "stock": 13,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001002",
                            "attrVv": "棕色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002003",
                            "attrVv": "30cm"
                        }]
                    }, {
                        "id": "c003001p001004",
                        "name": "光大之星E1级奥松板4444444",
                        "img":'https://jcz1206.github.io/static/prod/11.jpg',
                        "originPrice": "25.00",
                        "salePrice": "19.00",
                        "stock": 14,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002004",
                            "attrVv": "40cm"
                        }]
                    }]
                }, {
                    "spuid": "c003002",
                    "spuname": "兔宝宝生态板双层卡条",
                    "cateid": "c003002",
                    "img": "https://jcz1206.github.io/static/prod/60000116.jpg",
                       "sku": [{
                        "id": "c003002p001001",
                        "name": "兔宝宝生态板双层卡条1111111111",
                        "img": "https://jcz1206.github.io/static/prod/11.jpg",
                        "originPrice": "20.00",
                        "salePrice": "16.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002001",
                            "attrVv": "10cm"
                        }]
                    }, {
                        "id": "c003002p001002",
                        "name": "兔宝宝生态板双层卡条22222222222222",
                        "img":'https://jcz1206.github.io/static/prod/12.jpg',
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002002",
                            "attrVv": "20cm"
                        }]
                    }, {
                        "id": "c003002p001003",
                        "name": "兔宝宝生态板双层卡条333333333",
                        "img":'https://jcz1206.github.io/static/prod/12.jpg',
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002003",
                            "attrVv": "30cm"
                        }]
                    }]
                }, {
                    "spuid": "c003003",
                    "spuname": "纤维板",
                    "cateid": "c003003",
                    "img": "https://jcz1206.github.io/static/prod/13.jpg",
                        "sku": [{
                        "id": "c003003p001001",
                        "name": "纤维板11111111111",
                        "img": "hhttps://jcz1206.github.io/static/prod/14.jpg",
                        "originPrice": "20.00",
                        "salePrice": "16.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001002",
                            "attrVv": "棕色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002003",
                            "attrVv": "30cm"
                        }]
                    }, {
                        "id": "c003003p001002",
                        "name": "纤维板222222222222222",
                        "img":'https://jcz1206.github.io/static/prod/15.jpg',
                        "originPrice": "20.00",
                        "salePrice": "18.00",
                        "stock": 10,
                        "saleAttr": [{
                            "attrId": "a0001",
                            "attrName": "颜色",
                            "attrVId": "a0001001",
                            "attrVv": "白色"
                        }, {
                            "attrId": "10002",
                            "attrName": "规格",
                            "attrVId": "10002003",
                            "attrVv": "30cm"
                        }]
                    }]
                }]
</script>
