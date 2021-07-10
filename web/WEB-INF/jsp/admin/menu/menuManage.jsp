<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/css/layui.css"   media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layuimini.css?v=2.0.4.2" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/themes/default.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">

    <%-- 使用layui-dtree样式 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/font/dtreefont.css">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row">
            <%-- 左侧菜单树 --%>
            <div class="layui-col-md2">
                <!-- 树节点容器开始 -->
                <ul id="menuTree" class="dtree" data-id="0" style="width: 240px;"></ul>
                <!-- 树节点容器结束 -->
            </div>

            <%-- 右侧数据表格 --%>
            <div class="layui-col-md10">

                <%-- 表格工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加</button>
                    </div>
                </script>

                <%-- 数据表格 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-close"></i>删除</a>
                </script>

                <%-- 添加和修改窗口 --%>
                <div style="display: none;padding: 5px" id="addOrUpdateWindow">
                    <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                        <%-- 菜单编号 --%>
                        <input type="hidden" name="id" id="id">

                        <div class="layui-form-item">
                            <label class="layui-form-label">父级菜单</label>
                            <div class="layui-input-block">
                                <input type="hidden" name="pid" id="pid">
                                <ul id="menuSelectTree" class="dtree" data-id="0"></ul>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单名称</label>
                            <div class="layui-input-block">
                                <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="href"  autocomplete="off" placeholder="请输入菜单地址" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单图标</label>
                            <div class="layui-input-block">
                                <input type="hidden" id="icon" name="icon">
                                <input type="text" name="iconFa" id="iconPicker" lay-filter="iconPicker" autocomplete="off" placeholder="请输入菜单图标" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">是否展开</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="spread" value="1" title="是">
                                    <input type="radio" name="spread" value="0" title="否" checked>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-xs12">
                            <div class="layui-input-block" style="text-align: center;">
                                <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span class="layui-icon layui-icon-add-1"></span>提交</button>
                                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>清空</button>
                                <button type="button" class="layui-btn layui-btn-danger" id="resetMenu"><span class="layui-icon layui-icon-return"></span>重置菜单</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<%-- 导入layui的js文件--%>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.extend({
        //dtree脚本文件路径
        dtree:"${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree",
        iconPickerFa:"${pageContext.request.contextPath}/statics/layui/js/lay-module/iconPicker/iconPickerFa",
    }).use(['form','jquery','table','layer','dtree','iconPickerFa'],function () {
        var $ = layui.jquery,
            form = layui.form,
            layer = layui.layer;
            dtree = layui.dtree;
            table = layui.table;
            iconPickerFa = layui.iconPickerFa;

        //dtree渲染左侧菜单树
        var menuTree = dtree.render({
            elem: "#menuTree", //url头部ID属性值
            url: "/admin/menu/loadMenuTree", //请求地址
            dataStyle: "layuiStyle", //使用layui风格数据类型
            dataFormat: "list", //配置data的风格为list
            response:{message:"msg",statusCode:0}, //修改response中返回数据的定义
        });

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/menu/list',
            toolbar: '#toolbarDemo',

            cols: [[
                {field: 'id', width: 100, title: '菜单编号', align: "center"},
                {field: 'title', width: 180, title: '菜单名称', align: "center"},
                {field: 'href', minwidth: 200, title: '菜单地址', align: "center"},
                {field: 'spread', width: 100, title: '是否展开', align: "center",templet:function (s) {
                        return s.spread == 1 ? "<font color='#ff1493'>是</font>" : "<font color='#00ced1'>否</font>";
                    }},
                {field: 'icon', width: 100, title: '菜单图标', align: "center",templet:function (s) {
                        return "<i class='"+s.icon+"'></i>";
                    }},
                {title: '操作', width: 200, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
            //除第一页外，当前页删除最后一个数据时回到上一页
            done: function (res,curr,count) {
                //判断当前页吗是否大于1，且当前页数据量为0
                if(curr > 1 && res.data.length == 0){
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    });
                }
            }
        });

        //监听dtree点击事件
        dtree.on("node(menuTree)",function (obj) {
           tableIns.reload({
               where:{
                   //nodeId是选中节点的ID，官方的不可改
                   "id":obj.param.nodeId
               },
               page:{curr: 1}
           });
        });

        //先渲染父级菜单下拉菜单树组件
        var menuSelectTree = dtree.renderSelect({
            elem: "#menuSelectTree", //url头部ID属性值
            url: "/admin/menu/loadMenuTree", //请求地址
            dataStyle: "layuiStyle", //使用layui风格数据类型
            dataFormat: "list", //配置data的风格为list
            response:{message:"msg",statusCode:0}, //修改response中返回数据的定义
        });

        //监听下拉菜单选中事件
        dtree.on("node(menuSelectTree)",function (obj) {
            $("#pid").val(obj.param.nodeId);
        });

        table.on("toolbar(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "add":
                    openAddWindow();
                    break;
            }
        });

        //行工具栏
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

        function openAddWindow(data) {
            //隐藏域ID赋值
            mainIndex = layer.open({
                type: 1,
                title: "添加菜单",
                area: ["800px","500px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //清空表单数据，不然每次打开都会有上次的数据
                    $("#dataFrm")[0].reset();
                    //添加的请求
                    url = "/admin/menu/addMenu";
                    //设置默认的图标
                    iconPickerFa.checkIcon('iconPicker','fa fa-star');
                }
            });
        }

        function openUpdateWindow(data){
            mainIndex = layer.open({
                type: 1,
                title: "修改菜单",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    form.val("dataFrm",data);
                    url = "/admin/menu/updateMenu";

                    iconPickerFa.checkIcon('iconPicker',data.icon);//图标回显
                    dtree.dataInit('menuSelectTree',data.pid);//父级菜单回显
                    dtree.selectVal('menuSelectTree');

                    //判断当前节点是否是一级菜单（一级菜单无父级菜单）
                    if(data.pid == 0){
                        menuSelectTree.reload();
                    }
                }
            });
        }

        function deleteById(data){
            //判断是否有子菜单
            $.get("/admin/menu/checkMenuHasChild",{"id":data.id},function (result) {
                if(result.exist){
                    layer.msg(result.message);
                }else {
                    layer.confirm("确定要删除[<font color='#ff1493'>"+data.title+"</font>]吗",{icon: 3,title:'警告'}, function (index) {
                        $.post("/admin/menu/deleteById",{"id":data.id},function (result) {
                            if(result.success){
                                tableIns.reload();
                                menuTree.reload();
                                menuSelectTree.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            },"json");
        }

        //初始化下拉图标选择器
        iconPickerFa.render({
            elem: '#iconPicker',
            url: "/statics/layui/lib/font-awesome-4.7.0/less/variables.less",
            search: true,
            page: true,
            limit: 12,
            click: function (data) {
                $("#icon").val("fa "+data.icon);
            },
            success:function (s){
                console.log("s:"+s);
            }
        });

        form.on("submit(doSubmit)",function (data) {
            //发送ajax请求
            $.post(url,data.field,function (result) {
                //成功添加，数据都要刷新
                if(result.success){
                    //刷新数据表格
                    tableIns.reload();
                    //关闭窗口
                    layer.close(mainIndex);
                    //刷新左侧菜单树
                    menuTree.reload();
                    //刷新下拉菜单树
                    menuSelectTree.reload();
                }
                //信息反馈
                layer.msg(result.message)
            },"json")
            //禁止界面刷新
            return false;
        });

        //重置下拉菜单
        $('#resetMenu').click(function (){
           menuSelectTree.selectResetVal();
        });

    });




</script>


</html>
