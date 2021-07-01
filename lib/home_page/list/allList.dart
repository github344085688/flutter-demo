import 'package:flutter/material.dart';
List<Map> listbanexData = [
  {"imagUrl": "assets/images/av1.png",
    'price':10,
    'orPrice':200
  },
  {"imagUrl": "assets/images/av2.png",
    'price':20,
    'orPrice':210},
  {"imagUrl": "assets/images/av3.png",
    'price':50,
    'orPrice':580},
  {"imagUrl": "assets/images/av4.png",
    'price':300,
    'orPrice':1500},
  {"imagUrl": "assets/images/av5.png",
    'price':20,
    'orPrice':100},
  {"imagUrl": "assets/images/av6.png",
    'price':10,
    'orPrice':100},
  {"imagUrl": "assets/images/av7.png",
    'price':5,
    'orPrice':50},
];
List<Map> girdMenuWidgetData = [
  {'icon': Icons.delivery_dining},
  {'icon': Icons.all_out_sharp},
  {'icon': Icons.beach_access},
  {'icon': Icons.fire_hydrant},
  {'icon': Icons.free_breakfast},
  {'icon': Icons.fingerprint},
  {'icon': Icons.filter_drama_outlined},
  {'icon': Icons.blur_on_rounded},
  {'icon': Icons.bug_report_sharp},
  {'icon': Icons.deck_rounded},
];
List<Map> goulpkuData  = [
  {
    'bgiconColor': Color(0xffFAA426),
    'topiconColor': Color(0xffD48731),
    'containerColor': Color(0xffF6D1A7),
    'title':'01',
    'lable':'蛋黄女王IP人物形象设计',
    'text':'此篇仅发布了个人创作部分， '
        '蛋黄女王IP含有全套图库，'
        '可供授权  ',
    'bgUrl':'assets/images/banner_bg.png'
  },
  {
    'bgiconColor': Color(0xffEF5C63),
    'topiconColor': Color(0xffBF4A4F),
    'containerColor': Color(0xffFFE0E2),
    'title':'02',
    'lable':'项目练练手',
    'text':'最近想找个小项目练练手, '
        '图像主题色提取，颜色量子化， '
        '由图像生成调色板， ',
    'bgUrl':'assets/images/banner_bg.png'
  },
 /* {
    'bgiconColor': Color(0xff2DA0D1),
    'topiconColor': Color(0xff1383AA),
    'containerColor': Color(0xffCCF2FF),
    'title':'03',
    'lable':'Lorem Ipsum',
    'text':'Lorem ipsum dolor sit amet, '
        'consectetur adipiscing elitv. '
        'Proin sed neque sed lorem hendrerit ',
  },
  {
    'bgiconColor': Color(0xff435D74),
    'topiconColor': Color(0xff324657),
    'containerColor': Color(0xffE6F3FF),
    'title':'04',
    'lable':'Lorem Ipsum',
    'text':'Lorem ipsum dolor sit amet, '
        'consectetur adipiscing elitv. '
        'Proin sed neque sed lorem hendrerit ',
  },
  {
    'topiconColor': Color(0xff448C79),
    'bgiconColor': Color(0xff60C7AB),
    'containerColor': Color(0xffD1FFF2),
    'title':'05',
    'lable':'Lorem Ipsum',
    'text':'Lorem ipsum dolor sit amet, '
        'consectetur adipiscing elitv. '
        'Proin sed neque sed lorem hendrerit ',
  },*/
];

List <Map> bannerColors = [
  {"maiColor": Color(0xff779B38),"fuColor":Color(0xffA0BF72)},
  {"maiColor": Color(0xff435D74),"fuColor":Color(0xff435D74)},
  {"maiColor": Color(0xff448C79),"fuColor":Color(0xff60C7AB)},
  {"maiColor": Color(0xffFF0AF50),"fuColor":Color(0xffF9DDB7)},
  {"maiColor": Color(0xff936092),"fuColor":Color(0xffC89EC5)},
];

List<Map> goodsWomenList = [
  {
    "id": "1",
    "url":
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20173_27_6%2Fa4117n0586357033016.gif&refer=http%3A%2F%2Fs9.rr.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622363183&t=910efcc1feb2822cee4d3240bfb89202",
    "name": "VOA暗纹提花真丝纯色圆领长袖系带两用宽大知性飘逸桑蚕丝连衣裙女 A6057 落霞红(204) 170/XL",
    "price": "759.00",
    "shop": "VOA旗舰店",
    "evaluate": "100+"
  },
  {
    "id": "2",
    "url":
    "https://img13.360buyimg.com/n7/jfs/t1/82395/2/13256/65004/5da9277bE5b9c326a/8a2b6f47e05ed484.jpg",
    "name": "VOA女装 黑色藏青杭州重磅真丝松紧腰斜插袋运动休闲长裤子子K5800 北角夜色",
    "price": "459.00",
    "shop": "VOA旗舰店",
    "evaluate": "100+"
  },
  {
    "id": "3",
    "url":
    "https://img13.360buyimg.com/n7/jfs/t1/82395/2/13256/65004/5da9277bE5b9c326a/8a2b6f47e05ed484.jpg",
    "name": "VOA暗纹提花真丝纯色圆领长袖系带两用宽大知性飘逸桑蚕丝连衣裙女 A6057 落霞红(204) 170/XL",
    "price": "759.00",
    "shop": "VOA旗舰店",
    "evaluate": "100+"
  },
  {
    "id": "4",
    "url":
    "https://img11.360buyimg.com/n7/jfs/t1/170685/12/8383/236713/603af578E5954e8b4/ed216471c0008672.jpg",
    "name": "【跨年盛典】旅行便携 轻薄蓄热 高梵2020秋冬新品时尚连帽立领 轻薄羽绒服女 短款 修身显瘦 中国红-连帽 170/XL",
    "price": "189.00",
    "shop": "高梵女装旗舰店",
    "evaluate": "2000+"
  },
  {
    "id": "5",
    "url":
    "https://img10.360buyimg.com/n7/jfs/t1/166248/16/12211/142356/604c73dbEfc0fa567/3d3ce489169465e7.jpg",
    "name": "坦博尔女士羽绒服女轻薄短款秋冬新款修身时尚休闲纯色百搭连帽羽绒衣 TD3338 黑色 170/92A（尺码偏小)",
    "price": "199.00",
    "shop": "坦博尔女装旗舰店",
    "evaluate": "1万+"
  },
  {
    "id": "6",
    "url":
    "https://img10.360buyimg.com/n7/jfs/t1/163125/18/12544/177808/604f85d9E35f1f0a5/a0ff1e1950e50bbd.jpg",
    "name": "【早春上新】木真了中式立领刺绣大衣唐装新款羊毛呢大衣冬中长款 1121 07浅灰色 M",
    "price": "780.00",
    "shop": "木真了官方旗舰店",
    "evaluate": "97+"
  },
  {
    "id": "7",
    "url":
    "https://img11.360buyimg.com/n7/jfs/t1/165267/24/12519/210633/604ef9beEcf2e7e56/4b493ffec7306e1b.jpg",
    "name": "PORTS宝姿 冬款简约素雅羊绒大衣LS9C081DWI02 SEA GREEN/海绿 6(165/88Y)",
    "price": "3337.00",
    "shop": "PORTS旗舰店",
    "evaluate": "84+"
  },
  {
    "id": "8",
    "url":
    "https://img13.360buyimg.com/n7/jfs/t1/94889/32/3084/152567/5ddd709dE50f60de1/6d4deda3d1bcc509.jpg",
    "name":
    "魔之韵休闲裤女打底裤女外穿加绒加厚棉裤女士保暖裤子秋冬季显瘦弹力松紧腰大码胖mm200斤小脚181 黑色加绒 6XL(195-225斤左右)",
    "price": "88.00",
    "shop": "魔之韵旗舰店",
    "evaluate": "4000+"
  },
  {
    "id": "9",
    "url":
    "https://img13.360buyimg.com/n7/jfs/t3151/253/4314295508/290615/4e687e64/58401166Nb2756c29.jpg",
    "name":
    "魔之韵休闲裤女裤子长裤打底高腰薄款春秋季小脚铅笔裤加厚加绒保暖女士棉裤冬大码胖妹妹加绒裤A533 黑色加绒 4XL(158-178斤左右)",
    "price": "118.00",
    "shop": "魔之韵旗舰店",
    "evaluate": "3000+"
  },
  {
    "id": "10",
    "url":
    "https://img11.360buyimg.com/n7/jfs/t3949/247/945218534/201599/4144b022/586208a9N77c2c2ee.jpg",
    "name": "日着休闲裤女原创设计师女装女士休闲裤白色休闲裤女七分裤春秋新款萝卜裤 黑色现货 L",
    "price": "489.00",
    "shop": "日着旗舰店",
    "evaluate": "400+"
  }
];