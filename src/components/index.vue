<template>
    <div id="index">
        <!--<headbar></headbar>-->
        <div>
            <header>
                <div class="header-wrap">
                    <form>
                        <div class="site">南京1站<i class="icon iconfont icon-xiala"></i></div>
                        <i class="icon iconfont icon-sousuo"></i>
                        <input type="search" class="search" @search="search()">
                    </form>
                </div>
            </header>
            <!--喇叭-->
            <div class="trumpt"  v-if="data!=null">
                <div class="col-1 dsmall">
                    <i class="icon iconfont icon-shengyin"></i>
                </div>
                <div id="scroll_div" class="gg2 col-10">
                    <div id="scroll_begin">
                        <ul id="au">
                            <li v-for="item in data.trumpt" >
                                <a href="http://www.SuperSlide2.com" target="_blank">
                                    <p>{{item.title}}</p>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div id="scroll_end"></div>
                </div>
                <div class="col-1 dsmall" @click="hideTrumpt()">
                    <i class="icon iconfont icon-cuowu icancel"></i>
                </div>
            </div>
            <!--轮播图-->
            <div class="swiper-container"  v-if="data!=null">
                <div class="swiper-wrapper" style="z-index:4;background-color: rgba(0,0,0,0);">
                    <a v-for="item in data.advert" :href="item.url" class="swiper-slide" >
                        <span :style="'background-image:url('+item.img+')'"></span>
                    </a>
                </div>
                <div class="swiper-pagination"></div>
            </div>
            <!--分类-->
            <div class="category"  v-if="data!=null">
                <div v-for="item in data.category">
                    <router-link :to="item.url" >
                        <div :style="'background-image:url('+item.img+')'"></div>
                        <span>{{item.title}}</span>
                    </router-link>
                </div>
            </div>
            <!--头条-->
            <div class="txtMarquee-left"  v-if="data!=null">
                <div class="hd">
                    <span></span>
                    <!-- <a class="next"></a>
                    <a class="prev"></a> -->
                </div>
                <div class="bd">
                    <div class="tempWrap" style="overflow:hidden; position:relative; ">
                        <ul class="infoList">
                            <li v-for="item in data.trumpt">
                                <a href="http://www.SuperSlide2.com" target="_blank">{{item.title}}</a>
                                <span></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--活动-->
            <div>
              jjh
            </div>
        </div>
        <footbar></footbar>
    </div>
</template>

<script>
import '@/assets/css/base/common.scss'
import '@/assets/css/index/main.scss'
import "../assets/lib/swiper-4.0.5/css/swiper.css";
import headbar from "@/components/headbar.vue";
import footbar from "@/components/footbar.vue";
import Swiper from "@/assets/lib/swiper-4.0.5/js/swiper";
// import {Swiper} from 'imports?jQuery=jquery!@/assets/lib/swiper-4.0.5/js/swiper.min'
// require('@/assets/lib/SuperSlide2.1-demo-00/default.css')
// import SuperSlide from '@/assets/lib/SuperSlide2.1-demo-00/jquery.SuperSlide.2.1.1'
export default {
  name: "index",
  components: {
    // headbar,
    footbar
  },
  data() {
    return {
      // data: null
        data: {
              trumpt: [
                { title: "1快递盒子千万别扔2", url: "", type: 0 },
                { title: "3华为华为华为哈弗哈弗哈弗哈弗哈弗4", url: "", type: 0 },
                { title: "5全面屏全面屏全面屏全面屏全面屏全面屏全面屏全面屏全面屏全面屏6", url: "", type: 0 },
                {
                  title: "7飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行飞猪旅行8",
                  url: "",
                  type: 0
                }
              ],
              advert: [
                { img: require("@/assets/images/banner1.jpg"), url: "#", type: 0 },
                { img: require("@/assets/images/banner2.jpg"), url: "#", type: 0 },
                { img: require("@/assets/images/banner3.jpg"), url: "#", type: 0 },
                { img: require("@/assets/images/banner4.jpg"), url: "#", type: 0 }
              ],
              category: [
                {
                  title: "天猫",
                  img: require("@/assets/images/category/1.png"),
                  url:
                    "https://www.tmall.com/?locate=icon-1&spm=a215s.7406091.icons.1&scm=2027.1.2.1000&force=m&wh_from=tbc#/main",
                  type: 0
                },
                {
                  title: "聚划算",
                  img: require("../assets/images/category/2.png"),
                  url:
                    "https://jhs.m.taobao.com/m/index.htm?locate=icon-2&spm=a215s.7406091.icons.2&scm=2027.1.2.1001",
                  type: 0
                },
                {
                  title: "天猫国际",
                  img: require("../assets/images/category/3.png"),
                  url:
                    "https://pages.tmall.com/wow/import/17151/tmallglobal?locate=icon-3&spm=a215s.7406091.icons.3&scm=2027.4.1.16",
                  type: 0
                },
                {
                  title: "外卖",
                  img: require("../assets/images/category/4.png"),
                  url:
                    "https://market.m.taobao.com/apps/pm/paimai/index.html?wh_weex=true&wx_navbar_transparent=true&data_prefetch=true&locate=icon-9&spm=a215s.7406091.icons.9&scm=2027.1.2.10060000",
                  type: 0
                },
                {
                  title: "天猫超市",
                  img: require("../assets/images/category/5.png"),
                  url:
                    "https://chaoshi.m.tmall.com/?locate=icon-5&spm=a215s.7406091.icons.5&scm=2027.1.2.1007&_ig=shoutao",
                  type: 0
                },
                {
                  title: "天猫",
                  img: require("@/assets/images/category/1.png"),
                  url: "",
                  type: 0
                },
                {
                  title: "聚划算",
                  img: require("../assets/images/category/2.png"),
                  url: "",
                  type: 0
                },
                {
                  title: "天猫国际",
                  img: require("../assets/images/category/3.png"),
                  url: "",
                  type: 0
                },
                {
                  title: "外卖",
                  img: require("../assets/images/category/4.png"),
                  url: "",
                  type: 0
                },
                {
                  title: "天猫超市",
                  img: require("../assets/images/category/5.png"),
                  url: "",
                  type: 0
                }
              ],
              activity: []
        }
    };
  },
  mounted: function() {
      this.getData();
  },
  methods: {
    // share:function(){
    //   $('#share-3').share();
    // }
    getData: function() {
      this.axios.post('SFJ_M/indexPage/getIndexAdList').then((response)=>{
        console.log(response);

      }).catch((response)=>{
        console.log("====");
        console.log(response);
      })

      // this.$http.get(staticPath+"/indexjson").then(
      //   response => {
      //     this.data = response.data;
      //     this.$nextTick(function() {
      //       this.swiperTool();
      //       this.marqueeTool();
      //       this.scrollTrumpt();
      //     });
      //   },
      //   response => {
      //     // 响应错误回调
      //     alert("服务器请求失败");
      //   }
      // );

      // this.axi.get("/indexjson").then(
      //   response => {
      //     this.data = response;
      //     this.$nextTick(function() {
      //       this.swiperTool();
      //       this.marqueeTool();
      //       this.scrollTrumpt();
      //     });
      //   },
      //   response => {
      //     // 响应错误回调
      //     alert("服务器请求失败");
      //   }
      // );
    },
    search: () => {
      layer.alert("搜索内容是" + $(event.currentTarget).val());
    },
    swiperTool: () => {
      new Swiper(".swiper-container", {
        loop: true,
        autoplay: true, //等同于以下设置
        /*autoplay: {
            delay: 3000,
            stopOnLastSlide: false,
            disableOnInteraction: true,
            },*/
        delay: 500, //5秒切换一次
        disableOnInteraction: false, //false: 触碰后自动切换也不会停止
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
          renderBullet: function(index, className) {
            return '<span class="' + className + '">' + (index + 1) + "</span>";
          }
        }
      });
    },
    marqueeTool: () => {
      jQuery(".txtMarquee-left").slide({
        mainCell: ".bd ul",
        autoPlay: true,
        effect: "leftMarquee",
        interTime: 50,
        trigger: "click"
      });
      // jQuery(".txtMarquee-left").slide( { mainCell:".bd ul", autoPlay:true,effect:'leftMarquee',vis:3,interTime:50,opp:false,pnLoop:true,trigger:click,mouseOverStop:true  });
    },
    scrollTrumpt: () => {
      if (null == sessionStorage.showTrump || "" == sessionStorage.showTrump) {
        if (this.trumpt != []) {
          let speed = 50;
          var scroll_div = $("#scroll_div")[0],
            scroll_begin = $("#scroll_begin")[0],
            scroll_end = $("#scroll_end");

          var linum = Math.round(
            scroll_div.offsetWidth / scroll_begin.offsetWidth
          ); //有几个消息长度
          console.log(linum);
          if (linum > 1) {
            var lic = 0,
              newHtml = "";
            var copyHtml = scroll_begin.innerHTML;
            while (0 < linum) {
              newHtml += copayHtml;
            }
            scroll_begin.innerHTML = newhtml;
          }
          scroll_end.append(scroll_begin.innerHTML);
          var marqueeFn = () => {
            if (scroll_begin.offsetWidth > scroll_div.scrollLeft) {
              scroll_div.scrollLeft++;
            } else {
              scroll_div.scrollLeft -= scroll_begin.offsetWidth;
            }
          };
          setInterval(marqueeFn, speed);
        } else {
        }
      } else {
        this.hideTrumpt();
      }
    },
    hideTrumpt: () => {
      sessionStorage.showTrump = 1;
      $(".trumpt").hide();
    }
  }
};
</script>