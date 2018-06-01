//
//  FakeModelCreator.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/5/31.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class FakeModelCreator {
    
    static let shared = FakeModelCreator()
    
    fileprivate let avatarUrls = ["http://oo8snaf4x.bkt.clouddn.com/doge.jpg",
                             "http://oo8snaf4x.bkt.clouddn.com/1a47fcc17d2e46b5b0d3e0f160d98a0320180123163519.jpg",
                             "http://oo8snaf4x.bkt.clouddn.com/Unknown.jpg",
                             "http://oo8snaf4x.bkt.clouddn.com/1.jpg",
                             "http://oo8snaf4x.bkt.clouddn.com/Zjd3-fyiiahz2863063.jpg",
                             "http://oo8snaf4x.bkt.clouddn.com/WechatIMG11.jpeg",
                             "http://oo8snaf4x.bkt.clouddn.com/WechatIMG14.jpeg",
                             "http://oo8snaf4x.bkt.clouddn.com/WechatIMG12.jpeg",
                             "http://oo8snaf4x.bkt.clouddn.com/WechatIMG13.jpeg"]
    //"http://oo8snaf4x.bkt.clouddn.com/avater_placeholder@2x.png"
    
    fileprivate let defaultAvatarImgPath = "icon_avatarImg"
    
    fileprivate let names = [
        "结局更加忧伤",
        "污力满满",
        "不矜",
        "野性子#",
        "炙痛",
        "年少轻狂放纵不羁爱自由",
        "钻石般闪耀的男人i",
        "就把心酸当笑说",
        "滑落的照片让我变沉默╰",
        "病态女王",
        "一个人",
        "夜流逝",
        "never°",
        "(_涙嘚痕jǐ灬"
    ]
    
    fileprivate let imgUrls = [
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG18.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG33.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG31.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG16.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG27.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG17.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG21.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG26.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG28.png",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG22.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG25.png",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG20.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG29.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG32.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG19.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG24.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG30.jpeg",
        "http://oo8snaf4x.bkt.clouddn.com/WechatIMG23.jpeg"]
    
    fileprivate let defaultWeiboImgPath = "icon_feed_img"
    
    fileprivate let weiboMessages = [
        "闪电从不打在相同的地方，人不该被相同的方式伤害两次。",
        "善良的人永远是受苦的，那忧苦的重担似乎是与生俱来的，因此只有忍耐。",
        "上有天，下有地，中间站着你自己，做一天人，尽一天人事儿。",
        "摔倒了爬起来就好。",
        "虽然过去不能改变，未来可以。",
        "太阳照亮人生的路，月亮照亮心灵的路。",
        "我们必须拿我们所有的，去换我们所没有的。",
        "只要你确信自己正确就去做。做了有人说不好，不做还是有人说不好，不要逃避批判。",
        "做事成功的要诀就如同钥匙开锁的道理一样，如果你不能准确对号，那麽一定无法打开成功之门。",
        "想的多一定没做的多有效，然而不想便做一定没什么效果。",
        "幸福就像香水，洒给别人也一定会感染自己。",
        "学会下一次进步，是做大自己的有效法则。因此千万不要让自己睡在已有的成功温床上。",
        "要做的事情总找得出时间和机会；不愿意做的事情也总能找得出借口。",
        "有能力的人影响别人，没能力的人，受人影响。",
        "有智者立长志，无志者长立志。",
        "世上无难事，只要肯登攀。",
        "勤奋是学习的枝叶，当然很苦，智慧是学习的花朵，当然香郁。",
        "不求做的最好，但求做的更好。",
        "冰冻三尺，非一日之寒，成大事者不拘小节。",
        "是金子总会发光。"
    ]
    
    fileprivate let userMessages = [
        "蝶恋花·柳永\n伫倚危楼风细细，望极春愁，黯黯生天际。\n草色烟光残照里，无言谁会凭阑意。\n拟把疏狂图一醉，对酒当歌，强乐还无味。\n衣带渐宽终不悔，为伊消得人憔悴。",
        "蝶恋花·王维\n阅尽天涯离别苦,不道归来,零落花如许。\n花底相看无一语,绿窗春与天俱莫。\n待把相思灯下诉,一缕新欢,旧恨千千缕。\n最是人间留不住,朱颜辞镜花辞树。",
        "水调歌头·明月几时有\n宋代：苏轼\n丙辰中秋，欢饮达旦，大醉，作此篇，兼怀子由。\n明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？\n转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。",
        "卜算子·咏梅 \n宋代：陆游\n驿外断桥边，寂寞开无主。已是黄昏独自愁，更著风和雨。\n无意苦争春，一任群芳妒。零落成泥碾作尘，只有香如故。",
        "声声慢·寻寻觅觅\n宋代：李清照\n寻寻觅觅，冷冷清清，凄凄惨惨戚戚。乍暖还寒时候，最难将息。三杯两盏淡酒，怎敌他、晚来风急？雁过也，正伤心，却是旧时相识。\n满地黄花堆积。憔悴损，如今有谁堪摘？守着窗儿，独自怎生得黑？梧桐更兼细雨，到黄昏、点点滴滴。这次第，怎一个愁字了得！（守着窗儿 一作：守著窗儿）",
        "全是宋词吗?????? 再睿智点?????",
        "🙂🙂🙂🙂🙂🙂🙂",
//        "《滕王阁序》王勃\n豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区，童子何知，躬逢胜饯。\n\n时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得天人之旧馆。层台耸翠，上出重霄；飞阁翔丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势。披绣闼，俯雕甍：山原旷其盈视，川泽纡其骇瞩。闾阎扑地，钟鸣鼎食之家；舸舰迷津，青雀黄龙之轴。云销雨霁，彩彻区明。落霞与孤鹜齐飞，秋水共长天一色。渔舟唱晚，响穷彭蠡之滨；雁阵惊寒，声断衡阳之浦。\n\n遥襟甫畅，逸兴遄飞。爽籁发而清风生，纤歌凝而白云遏。睢园绿竹，气凌彭泽之樽；邺水朱华，光照临川之笔。四美具，二难并。穷睇眄于中天，极娱游于暇日。天高地迥，觉宇宙之无穷；兴尽悲来，识盈虚之有数。望长安于日下，目吴会于云间。地势极而南溟深，天柱高而北辰远。关山难越，谁悲失路之人；沟水相逢，尽是他乡之客。怀帝阍而不见，奉宣室以何年。嗟乎！时运不齐，命途多舛；冯唐易老，李广难封。屈贾谊于长沙，非无圣主；窜梁鸿于海曲，岂乏明时。所赖君子见机，达人知命。老当益壮，宁移白首之心；穷且益坚，不坠青云之志。酌贪泉而觉爽，处涸辙而相欢。北海虽赊，扶摇可接；东隅已逝，桑榆非晚。孟尝高洁，空余报国之情；阮籍猖狂，岂效穷途之哭！\n\n勃，三尺微命，一介书生。无路请缨，等终军之弱冠；有怀投笔，爱宗悫之长风。舍簪笏于百龄，奉晨昏于万里。非谢家之宝树，接孟氏之芳邻。他日趋庭，叨陪鲤对；今兹捧袂，喜托龙门。杨意不逢，抚凌云而自惜；钟期相遇，奏流水以何惭。呜呼！胜地不常，盛筵难再；兰亭已矣，梓泽丘墟。临别赠言，幸承恩于伟饯；登高作赋，是所望于群公。敢竭鄙怀，恭疏短引；一言均赋，四韵俱成。请洒潘江，各倾陆海云尔。\n滕王高阁临江渚，佩玉鸣鸾罢歌舞。\n画栋朝飞南浦云，珠帘暮卷西山雨。\n闲云潭影日悠悠，物换星移几度秋。\n阁中帝子今何在？槛外长江空自流。",
        "寒食\n韩翃\n春城无处不飞花，寒食东风御柳斜。\n日暮汉宫传蜡烛，轻烟散入五侯家。",
        "凉州词\n王之涣\n黄河远上白云间，一片孤城万仞山。\n羌笛何须怨杨柳，春风不度玉门关。",
        "求求你们别学了，跟不上了啊啊啊",
        "正常点"
    ]
    
    fileprivate let userTitles = [
        "晚上有去图书馆的吗?",
        "收妹子啦，无限收😛",
        "距离高考还有xx天，来说说你的看法",
        "有人一起报名美团的Coder比赛吗？",
        "大家都去哪实习？",
        "小米8就是弱智，不服来辩",
        "CSAPP的实验有人会吗",
        "听说xxx在东方红，快来人",
        "无言独上西楼...",
        "研楼最美🙃",
        "谁能教教我游泳吗",
        "马上就要毕业啦!!!",
        "跳蚤市场还有10天上线"
    ]
    
    fileprivate let userComments = [
        "好啊好啊😍",
        "楼主好棒棒💯",
        "我就想说一句，在座的都是我大哥",
        "没有人，嘻嘻😝",
        "非常赞同，本自同根生",
        "前排吃瓜",
        "火钳刘明",
        "那你可真睿智",
        "那个人的微博找到了@带带大师兄"
    ]
    
    fileprivate func timeUserIDCreator() -> Int {
        let now = Date()
        return Int(now.timeIntervalSince1970)
    }
    
    fileprivate func randomNumCreator(withMaximum maximum: Int) -> Int {
        return Int(arc4random() % UInt32(maximum))
    }
    
    static func weiboModelCreator() -> WeiboModel {
        let instance = FakeModelCreator.shared
        let model = WeiboModel(withBaseModel: instance.baseModelCreator())
        model.message = instance.weiboMessages[instance.randomNumCreator(withMaximum: instance.weiboMessages.count)]
        model.timeSincePost = String.getTimeString(withTimeInterval: Int(instance.timeUserIDCreator() - instance.randomNumCreator(withMaximum: 100000)))
        model.imgUrls = [
            instance.imgUrls[instance.randomNumCreator(withMaximum: instance.imgUrls.count)],
            instance.imgUrls[instance.randomNumCreator(withMaximum: instance.imgUrls.count)],
            instance.imgUrls[instance.randomNumCreator(withMaximum: instance.imgUrls.count)]
        ]
        model.dafaultImgPath = instance.defaultWeiboImgPath
        return model
    }
    
    static func userModelCreator() -> UserModel {
        return FakeModelCreator.userModelCreator(withComments: 0)
    }
    
    static func userModelCreator(withComments count: Int = 3) -> UserModel {
        let instance = FakeModelCreator.shared
        let model = UserModel(withBaseModel: instance.baseModelCreator())
        model.title = instance.userTitles[instance.randomNumCreator(withMaximum: instance.userTitles.count)]
        model.isUserLocalImage = false
        model.localImage = nil
        model.message = instance.userMessages[instance.randomNumCreator(withMaximum: instance.userMessages.count)]
        let time = Int(instance.timeUserIDCreator() - instance.randomNumCreator(withMaximum: 100000))
        model.timeSincePost = String.getTimeString(withTimeInterval: time)
        for _ in 0..<count {
            let commentModel = CommentModel(withBaseModel: instance.baseModelCreator())
            commentModel.comment = instance.userComments[instance.randomNumCreator(withMaximum: instance.userComments.count)]
            commentModel.commentPostTime = String.getTimeString(withTimeInterval: time+instance.randomNumCreator(withMaximum: 5000))
            commentModel.isUserLocalImage = false
            commentModel.localImage = nil
            model.comments.append(commentModel)
        }
        return model
    }
    
    fileprivate func baseModelCreator() -> BaseModel {
        let model = BaseModel()
        model.userID = String(timeUserIDCreator())
        model.userName = names[randomNumCreator(withMaximum: names.count)]
        model.userAvatarUrl = avatarUrls[randomNumCreator(withMaximum: avatarUrls.count)]
        model.defaultAvatarImg = defaultAvatarImgPath
        return model
    }
}
