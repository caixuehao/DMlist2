# DMlist2


新
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
服务器信息
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
User表 (用户信息保存表)
username    string 用户名（唯一键）
nickname    string 昵称
password    string 密码
userType    string 用户类型
loginMode   number 登录状态
db          File   用来保存用于同步qt客户端的db文件

分组表 (分组信息保存表，表名用的FZ＋username来命名的)
ID              string 标识符
name            string 分组名
remark          string 备注
titleImageUrl   string 动漫封面图片的网址
titleImageFile  File   封面图片文件

番表（保存动漫信息,表名用的username来命名的）
name            string 动漫的名字
remark          string 备注
type            string 动漫类型（分组）对应分组表的ID
titleImageUrl   string 动漫封面图片的网址
titleImageFile  File   封面图片文件


Images(保存图片用来控制客户端显示的图片)
image       File    图片文件
imageUrl    string  图片网址
number      number  图片编号
type        string  图片类型
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
本地
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//appName.app目录//



//Document目录
用户信息.plist（第一次进入时创建）
            username string 用户名（唯一键）
            nickname    string 昵称
            password string 密码
            userType string 用户类型
            用户是第一顺位：bool
            本地上一次更新的时间：time

FZ＋username.plist
    ID              string 标识符
    name            string 分组名
    remark          string 备注
    titleImageUrl   string 动漫封面图片的网址
    titleImageFile  File   封面图片文件

username.plist
name            string 动漫的名字
remark          string 备注
type            string 动漫类型（分组）对应分组表的ID
titleImageUrl   string 动漫封面图片的网址
titleImageFile  File   封面图片文件

Image.plist
    图片类型：
    图片网址：url
    图片编号：number


	各种类型.png
