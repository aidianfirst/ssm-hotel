<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/css/layui.css"
          media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">
    <style>
        .thumbBox{ height:200px; overflow:hidden; border:1px solid #e6e6e6; border-radius:2px; cursor:pointer; position:relative; text-align:center; line-height:200px;width: 210px;}
        .thumbImg{ max-width:100%; max-height:100%; border:none;}
        .thumbBox:after{ position:absolute; width:100%; height:100%;line-height:200px; z-index:-1; text-align:center; font-size:20px; content:"缩略图"; left:0; top:0; color:#9F9F9F;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%-- 搜索条件 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">房间编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="roomNum" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">房间类型</label>
                            <div class="layui-input-inline">
                                <select name="roomTypeId" id="s_roomTypeId" autocomplete="off" class="layui-input">
                                    <option value="">全部</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属楼层</label>
                            <div class="layui-input-inline">
                                <select name="floorId" id="s_floorId" autocomplete="off" class="layui-input">
                                    <option value="">全部</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">房间状态</label>
                            <div class="layui-input-inline">
                                <select name="status" id="s_status" autocomplete="off" class="layui-input">
                                    <option value="">全部</option>
                                    <option value="1">可预订</option>
                                    <option value="2">已预订</option>
                                    <option value="3">已入住</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="text-align: center">
                            <button type="submit" class="layui-btn" lay-submit lay-filter="data-search-btn"><i
                                    class="layui-icon layui-icon-search"></i>搜索
                            </button>
                            <button type="reset" class="layui-btn layui-btn-warm"><i
                                    class="layui-icon layui-icon-refresh-1"></i>重置
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <%-- 表格工具栏 --%>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i
                        class="layui-icon layui-icon-add-1"></i>添加
                </button>
            </div>
        </script>

        <%-- 数据表格 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <%-- 行工具栏 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i
                    class="layui-icon layui-icon-close"></i>删除</a>
        </script>

        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                <!-- 隐藏域，保存房型id -->
                <input type="hidden" name="id">
                <div class="layui-col-md12 layui-col-xs12">
                    <div class="layui-row layui-col-space10">
                        <div class="layui-col-md9 layui-col-xs7">
                            <div class="layui-form-item magt3" style="margin-top: 8px;">
                                <label class="layui-form-label">房间编号</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="roomNum" lay-verify="required"  placeholder="请输入房间编号">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">房间类型</label>
                                <div class="layui-input-block">
                                    <select name="roomTypeId" id="roomTypeId" lay-verify="required">
                                        <option value="">请选择房型</option>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">房间备注</label>
                                <div class="layui-input-block">
                                    <textarea class="layui-textarea" name="remark" id="remark"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md3 layui-col-xs5">
                            <div class="layui-upload-list thumbBox mag0 magt3">
                                <input type="hidden" name="photo" id="photo" value="images/defaultimg.jpg">
                                <img class="layui-upload-img thumbImg" src="/hotel/show/images/defaultimg.jpg">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item magb0">
                        <div class="layui-inline">
                            <label class="layui-form-label">所属楼层</label>
                            <div class="layui-input-inline">
                                <select name="floorId" id="floorId" lay-verify="required">
                                    <option value="">请选择楼层</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">房间状态</label>
                            <div class="layui-input-inline">
                                <select name="status" id="status" lay-verify="required">
                                    <option value="">请选择房间状态</option>
                                    <option value="1">可预订</option>
                                    <option value="2">已预订</option>
                                    <option value="3">已入住</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">房间要求</label>
                        <div class="layui-input-block" >
                            <textarea id="roomRequirement" name="roomRequirement" class="layui-textarea"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">房间详情</label>
                        <div class="layui-input-block" >
                            <textarea id="roomDesc" name="roomDesc" style="display: none;"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="text-align: center;">
                            <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit" id="doSubmit"><span
                                    class="layui-icon layui-icon-add-1"></span>提交
                            </button>
                            <button type="reset" class="layui-btn layui-btn-warm"><span
                                    class="layui-icon layui-icon-refresh-1"></span>重置
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table', 'laydate', 'jquery', 'layer','upload','layedit'], function () {
        var $ = layui.jquery,
            form = layui.form,
            laydate = layui.laydate,
            upload = layui.upload,
            layedit = layui.layedit,
            layer = layui.layer,
            table = layui.table;

        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/room/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 60, title: '编号', align: "center"},
                {field: 'roomNum', minWidth: 120, title: '房间编号', align: "center"},
                {field: 'typeName', minWidth: 100, title: '房间类型', align: "center"},
                {field: 'floorName', minWidth: 100, title: '所属楼层', align: "center"},
                {field: 'statusStr', minWidth: 100, title: '房间状态', align: "center"},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
            done: function (res, curr, count) {
                //判断当前页码是否是大于1并且当前页的数据量为0
                if (curr > 1 && res.data.length == 0) {
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    });
                }
            }
        });

        //渲染文件上传区域
        upload.render({
            elem: ".thumbImg",
            url: "${pageContext.request.contextPath}/admin/file/upLoadFile",
            acceptMime: "image/*",//只能上传图片文件
            field: "file",//文件上传的字段值，与控制器方法参数名一致
            method: "post",
            //回调方法
            done: function (res,index,upload) {
                //设置图片回显路径
                $(".thumbImg").attr("src",res.data.src);
                $(".thumbBox").css("background","#fff");
                //更新隐藏域的值
                $("#photo").val(res.imagePath);
            }
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            tableIns.reload({
                where: data.field,
                page: {
                    curr: 1
                }
            });
            return false;
        });

        //查询 房型 楼层 下拉列表
        $.get("/admin/roomType/findAll",function (result) {
            var html = "";
            for(var i = 0 ;i<result.length;i++){
                html += "<option value='"+result[i].id+"'>"+result[i].typeName+"</option>"
            }
            //加入下拉列表
            $("[name='roomTypeId']").append(html);
            //重新渲染下拉
            form.render("select");
        },"json");

        $.get("/admin/floor/findAll",function (result) {
            var html = "";
            for(var i = 0 ;i<result.length;i++){
                html += "<option value='"+result[i].id+"'>"+result[i].name+"</option>"
            }
            //加入下拉列表
            $("[name='floorId']").append(html);
            //重新渲染下拉
            form.render("select");
        },"json");

        table.on("toolbar(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "add":
                    openAddWindow();
                    break;
            }
        });

        table.on("tool(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "edit":
                    openUpdateWindow(obj.data);
                    break;
                case "delete":
                    deleteById(obj.data);
                    break;
            }
        });

        var url,mainIndex;
        var detailIndex;//富文本编辑器索引

        function openAddWindow(data) {
            //隐藏域ID赋值
            mainIndex = layer.open({
                type: 1,
                title: "添加房间",
                area: ["800px","500px"],
                content: $("#addOrUpdateWindow"),
                maxmin: true,//窗口最大最小化
                success: function (){
                    //清空表单数据，不然每次打开都会有上次的数据
                    $("#dataFrm")[0].reset();
                    //添加的请求
                    url = "/admin/room/addRoom";
                    //重置图片及隐藏域
                    //src是文件绝对路径，所以加上/hotel/show/，这个对应tomcat设置的图片文件夹
                    $(".thumbImg").attr("src","/hotel/show/images/defaultimg.jpg");
                    $("#photo").val("images/defaultimg.jpg");
                }
            });
            //设置窗口打开为最大化
            layer.full(mainIndex);
            //初始化富文本编辑器
            detailIndex = layedit.build("roomDesc",{
                uploadImage:{
                    url: "/admin/file/upLoadFile",
                    type: "post"
                }
            });
        }

        function openUpdateWindow(data){
            mainIndex = layer.open({
                type: 1,
                title: "修改房间",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                maxmin: true,
                success: function (){
                    form.val("dataFrm",data);
                    url = "/admin/room/updateRoom";
                    //重置图片及隐藏域
                    $(".thumbImg").attr("src","/hotel/show/"+data.photo);
                    $("#photo").val(data.photo);
                }
            });
            layer.full(mainIndex);
            detailIndex = layedit.build("roomDesc",{
                uploadImage:{
                    url: "/admin/file/upLoadFile",
                    type: "post"
                }
            });
        }

        function deleteById(data){
            //判断当前房间状态
            if(data.status == 1){
                layer.confirm("确定要删除[<font color='#ff1493'>"+data.roomNum+"</font>]号房间吗",{icon: 3,title:'警告'}, function (index) {
                    //发送ajax请求进行删除
                    $.post("/admin/room/deleteById",{"id":data.id},function (result) {
                        if(result.success){
                            tableIns.reload();
                        }
                        layer.msg(result.message);
                    },"json");
                    layer.close(index);
                });
            }else{
                layer.msg("只能删除状态为可预订的房间");
            }
        }

        form.on("submit(doSubmit)",function (data) {
            //将富文本编辑器内容同步到文本域textarea
            layedit.sync(detailIndex);
            $.post(url,$("#dataFrm").serialize(),function (result) {
                if(result.success){
                    //刷新数据表格
                    tableIns.reload();
                    //关闭窗口
                    layer.close(mainIndex);
                }
                //信息反馈
                layer.msg(result.message)
            },"json")
            //禁止界面刷新
            return false;
        });

    });
</script>

</body>
</html>
