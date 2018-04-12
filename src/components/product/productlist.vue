<template>
<div>
    <category v-on:child-say="listenToMyBoy"></category>
    <!-- =={{cateid}}== -->
    <!-- <div v-for="item in data" v-if="item.cateid==cateid">
        {{item.spuname}}
    </div> -->
    <div class="prodlist">
        <div v-for="item in productlist" @key="item.spuid" >
            <div class="prodimg">
                <img v-lazy="item.sku[0].img"/>
            </div>
            <div class="prodcon">
                <div class="prodname">{{item.spuname}}</div>
                <!-- <div class="prodname">guige</div> -->
                <div class="prodbottom">
                    <div class="prodnumber">
                        <div class="prodprice">￥{{item.sku[0].salePrice}}</div>
                        <div class="prodstock">库存：{{item.sku|sumStock}}</div>
                    </div>
                    <div class="prodcart" @click="addCart(item)"><i class="icon iconfont icon-gouwuchetianjia"></i></div>
                </div>
            </div>
        </div>
        <div v-if="productlist.length==0">
            暂无商品
        </div>
    </div>
    <addcart v-if="selectedProd!=null" :selectSpu="selectedProd" ></addcart>
</div>
</template>
<script>
import '@/assets/css/base/common.scss'
import '@/assets/css/product/productlist.scss'
import category from "@/components/product/category.vue";
import addcart from "@/components/product/addcart.vue";
export default{
    name:"productlist",
    components:{
        category,
        addcart
    },
    data(){
        return {
            data:null,
            cateid:"jksdf",
            productlist:[],
            selectedProd:null
        }
    },
    filters:{
        sumStock:(skulist)=>{
            var stock=0;
            skulist.forEach((sku)=>{
                stock+=sku.stock;
            })
            return stock;
        }
    },
    mounted:function(){   
        document.querySelector('.nav2 a').dispatchEvent(new Event('click'));
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
                            this.productlist.push(spu);
                            // this.productlist.push(spu);
                            // this.productlist.push(spu);
                            // this.productlist.push(spu);
                            // this.productlist.push(spu);
                        }
                        // console.log(spu.spuname)
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
                    "img":"",
                    "sku": [{
                        "id": "c001001p001001",
                        "name": "水管哦1",
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
                        "id": "c001001p001002",
                        "name": "水管哦2",
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
                    "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000036.png",
                    "sku": [{
                        "id": "c003001p001001",
                        "name": "可耐福纸面石膏板",
                        "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000036.png",
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
                        "id": "c003001p001002",
                        "name": "光大之星E1级奥松板",
                        "img":'http://rlstest.shifuzhijia.com/SFJ/outImages/product/20170328102712595_7157676-360x360.jpg',
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
                    "spuid": "c003002",
                    "spuname": "兔宝宝生态板双层卡条",
                    "cateid": "c003002",
                    "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000116.jpg",
                       "sku": [{
                        "id": "c003002p001001",
                        "name": "兔宝宝生态板双层卡条1",
                        "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000116.jpg",
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
                        "id": "c003002p001002",
                        "name": "兔宝宝生态板双层卡条2",
                        "img":'http://rlstest.shifuzhijia.com/SFJ/outImages/product/20160616111226956_2780727-360x360.jpg',
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
                    "spuid": "c003003",
                    "spuname": "纤维板",
                    "cateid": "c003003",
                    "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000414.png",
                        "sku": [{
                        "id": "c003003p001001",
                        "name": "纤维板1",
                        "img": "http://rlstest.shifuzhijia.com/SFJ/outImages/product/60000414.png",
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
                        "id": "c003003p001002",
                        "name": "纤维板2",
                        "img":'http://rlstest.shifuzhijia.com/SFJ/outImages/product/20160616111226956_2780727-360x360.jpg',
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
                }]
</script>

<!--
            /*
            // this.axio({
            //     url:"/static/json/products.json",
            //     dataType:"json",
            //     success:(response)=>{
            //         this.data=response.data;
            //     },
            //     error:(response)=>{
            //         layer.alert("报错啦");
            //     }
            // })
            */
            -->

