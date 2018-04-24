<template>
<div>
    <category v-on:child-say="listenToMyBoy" :cateid="cateid"></category>
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
                        <div class="prodstock">库存：{{item.stock}}</div>
                        <!-- {{item|sumStock}}| -->
                    </div>
                    <div class="prodcart" @click="addCart(item)"><i class="icon iconfont icon-gouwuchetianjia"></i></div>
                </div>
            </div>
        </div>
        <div class="pageBottom"></div>
        <div v-if="productlist.length==0">
            暂无商品
        </div>
    </div>
    <addcart v-if="selectedProd!=null" :selectedSpu="selectedProd" ></addcart>
        <footbar></footbar>
</div>
</template>
<script>
import '@/assets/css/base/common.scss'
import '@/assets/css/product/productlist.scss'
import category from "@/components/product/category.vue";
import addcart from "@/components/product/addcart.vue";
import footbar from "@/components/footbar.vue";
export default{
    name:"productlist",
    components:{
        category,
        addcart,
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
    mounted:function(){   
        // document.querySelector('.nav2 a').dispatchEvent(new Event('click'));
        // console.log(this.$route.params.cid);
        this.getProductlist(this.cateid);
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
                            let totalstock=0;
                            if(skulist.length>1){
                                totalstock=skulist.reduce((previousValue=0, currentValue,index) => { 
                                    // if(typeof previousValue=="object"){
                                    if(index==1){
                                        return previousValue.stock + currentValue.stock;
                                    }else{
                                        return previousValue + currentValue.stock;
                                    }
                                });
                            }else{
                                totalstock=skulist[0].stock;
                            }
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
                }, {
                    "spuid": "c003004",
                    "spuname": "纤维板4444444444",
                    "cateid": "c003003",
                    "img": "https://jcz1206.github.io/static/prod/13.jpg",
                    "sku": [{
                        "id": "c003004p001001",
                        "name": "纤维板444444",
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
                    }]
                }, {
                    "spuid": "c003005",
                    "spuname": "纤维板55555555555",
                    "cateid": "c003003",
                    "img": "https://jcz1206.github.io/static/prod/13.jpg",
                    "sku": [{
                        "id": "c003005p001001",
                        "name": "纤维板5555555",
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
                    }]
                }, {
                    "spuid": "c003006",
                    "spuname": "纤维板6666666666666",
                    "cateid": "c003003",
                    "img": "https://jcz1206.github.io/static/prod/13.jpg",
                    "sku": [{
                        "id": "c003006p001001",
                        "name": "纤维板6666666",
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

