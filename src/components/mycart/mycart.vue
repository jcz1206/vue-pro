<template>
<div>
    <div></div>
    <div>Vuex临时存储,仅学习vuex</div>
    <keep-alive>
        <div  class="pcart">
            <div class="prodlist">
                <div v-for="(item,index) in productlist" @key="item.id" >
                    <div class="ft-cb o-t-item" >
                    <p >
                        <input :id="'cb-'+item.id"  type="checkbox" class="cb o-t-cb" :checked="item.sel" @click="checkSingleClick(item)">
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
                            <div class="prodcart ctrl-ui-sku">
                            <div class="sku-quantity">
                                <p class="btn-minus" :class="{'off':item.selCount<=1}"  @click="clickChangeBuyNum(0,item,index)"  @touchend="touchChangeBuyNum(0,item,index)"><a class="btn minus" min=""></a></p>
                                <p class="btn-input"><input type="tel" v-model="item.selCount" @blur="checkBuyNum(item,index)"></p>
                                <p class="btn-plus"  :class="{'off':item.selCount>=item.stock}" @click="clickChangeBuyNum(1,item,index)"  @touchend="touchChangeBuyNum(1,item,index)"><a class="btn plus" max=""></a></p>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="productlist.length==0">
                    <router-link to="productlist/c003">暂无商品，去商品选择商品吧</router-link>
                </div>
            </div>
        </div>
    </keep-alive>
    <!-- </keep-alive> -->
        <div class="cartbuy">
            <div class="footer" >
              <div class="f-fx" >
                <div>
                  <div class="ft-cb" >
                    <p>
                      <input id="cb-footer" type="checkbox" class="cb o-t-cb" :checked="ctotal" @click="checkTotalClick">
                      <label for="cb-footer" ></label>
                    </p>
                  </div>
                  <div class="qx" >全选</div>
                  <div class="pay" >
                    <div >
                      <div  >
                        <span class="hj" >合计：</span>
                        <p class="o-t-price" data-symbol="￥" >
                            <span>{{totalPrice}}</span>
                          <!-- <span ><span class="major" >0</span><span class="point" >.</span><span class="minor" >00</span></span> -->
                        </p>
                      </div>
                      <p></p>
                    </div>
                  </div>
                  <div class="btn" >
                    <p>
                      <span>结算</span><span>(</span><span>{{totalcount}}</span><span>)</span>
                    </p>
                  </div>
                </div>
              </div>
            </div>
        </div>
        <footbar></footbar>
</div>
</template>
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
            selectedProd:null,
            ctotal:false,
            totalcount:0,//选中的商品个数
            totalPrice:0.00,
        }
    },
    created:function(){
        this.productlist=this.$store.state.cart;
        this.getCount();
        this.getPrice();
    //   console.log(this.productlist);
    },
    mounted:function(){   
      // console.log(this.$store.state.cart);
        // document.querySelector('.nav2 a').dispatchEvent(new Event('click'));
        // console.log(this.$route.params.cid);
        // this.getProductlist(this.cateid);
    },
    computed: {
    },
    watch:{
//         ctotal(curVal,oldVal){
// // 　　　　　　console.log(curVal,oldVal);
//             // let totalcount=0;
//             this.productlist.map(function(item){
//                 // curVal?(totalcount+=item.selCount):"";
//                 return item.sel=curVal;
//             });
//             if(curVal){ 
//                 this.totalcount=this.productlist.length;
//             }else{
//                 // this.totalcount=document.querySelectorAll(".o-t-item .o-t-cb:checked").length;
//                 this.totalcount=this.productlist.filter(function(item){return item.sel;}).length;
//             }
// 　　　　},
    },
    methods:{
        getSelectProdList(){
            return this.productlist.filter(function(item){return item.sel;}) ;
        },
        getCount:function(){
            this.totalcount=this.getSelectProdList().length;
            if(this.totalcount==this.productlist.length&&this.totalcount!=0){
                this.ctotal=true;
            }else{
                this.ctotal=false;
            }
        },
        getPrice:function(){    
            let selectProdlist=this.getSelectProdList();    
            if(selectProdlist.length>1){
                this.totalPrice=
                selectProdlist.reduce(function(pre,cur,index){ 
                    if(index==1){
                        return parseFloat(pre.salePrice)*pre.selCount+parseFloat(cur.salePrice)*cur.selCount;
                    }else{
                        return pre+parseFloat(cur.salePrice)*cur.selCount;
                    }
                })
            }else if(selectProdlist.length==1){
                this.totalPrice=parseFloat(selectProdlist[0].salePrice)*selectProdlist[0].selCount;
            }
            else{
                this.totalPrice=0.00;
            }
        },
        checkTotalClick:function(){
            this.ctotal=!this.ctotal;
            let checkT=this.ctotal;
            this.productlist.map(function(item){
                // curVal?(totalcount+=item.selCount):"";
                return item.sel=checkT;
            });
            if(checkT){ 
                this.totalcount=this.productlist.length;
            }else{
                // this.totalcount=document.querySelectorAll(".o-t-item .o-t-cb:checked").length;
                this.totalcount=this.getSelectProdList().length;
            }
            this.$forceUpdate(); 
            this.getPrice();
        },
        checkSingleClick:function(item){
            item.sel=!item.sel;
            if(!item.sel){
                this.ctotal=false;
                this.totalcount--;
            }else{
                this.totalcount++;
                let checkT=this.getSelectProdList().length;
                if(this.totalcount==(checkT+1)){
                    this.ctotal=true;
                }
            }           
                this.$forceUpdate(); 
            this.getPrice();
        },
        checkBuyNum:function(prod,index){
            if(prod.selCount<1&&prod.stock>0) {            
                this.$forceUpdate(); 
                prod.selCount=1;
            }
            if(prod.selCount>prod.stock){            
                this.$forceUpdate(); 
                prod.selCount=prod.stock;
            }
                // this.$set(this.productlist[index], 'selCount', prod.selCount);
        },
        clickChangeBuyNum:function(...args){//点击改变购买个数 
            this.changeBuyNum(...args); 
        },
        touchChangeBuyNum:function(...args){//点击改变购买个数
            //加减速度修改
            var ua = window.navigator.userAgent.toLowerCase();
            if(ua.match(/MicroMessenger/i) == 'micromessenger'||/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)||/(Android)/i.test(navigator.userAgent)){
                this.changeBuyNum(...args);
                event.preventDefault();
            }else{
                return;
            }
        },
        changeBuyNum:function(type,prod){//点击改变购买个数        
            if(!$(event.currentTarget).hasClass("off")) {           
                this.$forceUpdate();  
                if (type == 0) {
                    if (prod.selCount > 1) {
                        prod.selCount = parseInt(prod.selCount) - 1;
                    }
                } else { 
                    if (prod.selCount < prod.stock) {
                        prod.selCount = parseInt(prod.selCount) + 1;
                    }
                }
                if(prod.sel){
                     this.getPrice();
                }
                // this.$set(this.productlist[index], 'selCount', prod.selCount);
                //这种没有解决 页面没有重新渲染selCount的问题，使用this.$forceUpdate();
                //百度，别人说他请教大神，才知道是数据层次太多，没有触发render函数进行自动更新，需手动调用                  
            }
        },
    }
}

</script>
