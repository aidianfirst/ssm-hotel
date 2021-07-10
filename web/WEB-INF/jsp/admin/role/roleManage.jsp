<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">

    <%-- 使用layui-dtree样式 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/font/dtreefont.css">

</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <%-- 搜索 --%>
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">角色名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="roleName" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn"  lay-submit lay-filter="data-search-btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
                            <button type="reset" class="layui-btn layui-btn-warm" ><i class=  "layui-icon layui-icon-refresh-1"></i>重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
        <%-- 头部工具栏 --%>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加</button>
            </div>
        </script>
        <%-- 表格区域 --%>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <%-- 每行的工具栏：修改、删除 --%>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-delete"></i>删除</a>
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="grantMenu"><i class="layui-icon layui-icon-edit"></i>管理权限</a>
        </script>

        <%-- 添加和修改窗口 --%>
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">

                <div class="layui-form-item">
                    <label class="layui-form-label">角色名称</label>
                    <div class="layui-input-block">
                        <%-- 隐藏id --%>
                        <input type="hidden" name="id">
                        <input type="text" name="roleName" lay-verify="required" autocomplete="off"
                               placeholder="请输入角色名称" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">角色备注</label>
                    <div class="layui-input-block">
                        <textarea class="layui-textarea" name="roleDesc" id="roleDesc"></textarea>
                    </div>
                </div>
                <div class="layui-form-item layui-row layui-col-xs12">
                    <div class="layui-input-block" style="text-align: center;">
                        <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span
                                class="layui-icon layui-icon-add-1"></span>提交
                        </button>
                        <button type="reset" class="layui-btn layui-btn-warm"><span
                                class="layui-icon layui-icon-refresh-1"></span>重置
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <%-- 菜单的弹出层 --%>
        <div style="display: none;" id="selectRoleMenuDiv">
            <ul id="roleTree" class="dtree" data-id="0"></ul>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.extend({
        //dtree脚本文件路径
        dtree:"${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree",
    }).use(['form', 'table','layer','laydate','jquery','dtree'], function () {
        var $ = layui.jquery,
            form = layui.form,
            layer = layui.layer;
            dtree = layui.dtree;
            laydate = layui.laydate;
            table = layui.table;

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/role/list',
            toolbar: '#toolbarDemo',

            cols: [[
                {field: 'id', width: 100, title: '角色编号', align: "center"},
                {field: 'roleName', minWidth: 150, title: '角色名称', align: "center"},
                {field: 'roleDesc', minWidth: 200, title: '角色描述', align: "center"},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
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

        /**
         * toolbar监听事件
         * currentTableFilter是表格lay-filter过滤器的值
         */
        table.on("toolbar(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "add":
                    openAddWindow();
                    break;
            }
        });

        //监听行工具栏事件
        table.on("tool(currentTableFilter)",function (obj) {
            switch(obj.event){
                case "edit":
                    openUpdateWindow(obj.data);
                    break;
                case "delete":
                    deleteById(obj.data);
                    break;
                case "grantMenu":
                    openGrantMenuWindow(obj.data);
                    break;
            }
        });


        var url;//提交地址
        var mainIndex;//打开窗口的索引

        // 打开添加窗口
        function openAddWindow(){
            mainIndex = layer.open({
                type: 1,
                title: "添加角色",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //清空表单数据，不然每次打开都会有上次的数据
                    $("#dataFrm")[0].reset();
                    //添加的请求
                    url = "/admin/role/addRole";
                }
            });
        }

        function openUpdateWindow(data){
            mainIndex = layer.open({
                type: 1,
                title: "修改角色",
                area: ["800px","400px"],
                content: $("#addOrUpdateWindow"),
                success: function (){
                    //表单数据回显
                    //lay-filter对象，回显数据
                    form.val("dataFrm",data);
                    //修改的请求
                    url = "/admin/role/updateRole";
                }
            });
        }

        //删除部门
        function deleteById(data){
            //判断当前部门是否有员工
            $.get("/admin/role/checkRoleHasEmployee",{"id":data.id},function (result) {
                if(result.exist){
                    //若存在员工，提示用户无法删除
                    layer.msg(result.message);
                }else {
                    //不存在员工，提示用户是否删除
                    layer.confirm("确定要删除[<font color='#ff1493'>"+data.roleName+"</font>]吗",{icon: 3,title:'警告'}, function (index) {
                        //发送ajax请求进行删除
                        $.post("/admin/role/deleteById",{"id":data.id},function (result) {
                            if(result.success){
                                tableIns.reload();
                            }
                            layer.msg(result.message);
                        },"json");
                        layer.close(index);
                    });
                }
            },"json");
        }

        //权限分配菜单
        function openGrantMenuWindow(data){
            mainIndex = layer.open({
                type: 1,
                title: "分配[<font color='#ff1493'>"+data.roleName+"</font>]的权限菜单",
                area: ["400px","480px"],
                content: $("#selectRoleMenuDiv"),
                btn: ['确认', '取消'],
                yes: function(index, layero){
                    //获取复选框选中的值
                    var params = dtree.getCheckbarNodesParam("roleTree");
                    //发送ajax请求，保存选中的菜单ID
                    if(params.length>0){
                        var idArr = [];
                        //循环获取选中框的ID
                        for(var i=0; i<params.length; i++){
                            //nodeId为选中树节点值，固定写法不可修改
                            idArr.push(params[i].nodeId);
                        }
                        //数组转换成字符串，ids选中菜单的ID值
                        var ids = idArr.join(",");
                        $.post("/admin/role/saveRoleMenu",{"ids":ids,"roleId":data.id},function (result) {
                            layer.msg(result.message);
                        },"json");

                    }else {
                        layer.msg("请选择要分配的菜单!");
                    }

                },
                no: function(index, layero){

                },
                success: function (){
                    //渲染dtree组件
                    dtree.render({
                        elem: "#roleTree", //url头部ID属性值
                        url: "/admin/role/initMenuTree?roleId="+data.id, //请求地址
                        dataStyle: "layuiStyle", //使用layui风格数据类型
                        dataFormat: "list", //配置data的风格为list
                        response:{message:"msg",statusCode:0}, //修改response中返回数据的定义
                        checkbar: true,
                        checkbarType: "all" //有多种复选框格式
                    });
                }
            });
        }

        // 监听表单提交事件
        form.on("submit(doSubmit)",function (data) {
            //发送ajax请求
            $.post(url,data.field,function (result) {
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
