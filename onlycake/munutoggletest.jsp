<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <title>정렬 기능</title>
    <meta charset="EUC-KR">
    <script>
        function toggleSortMenu() {
            const sortMenu = document.getElementById('sortMenu');
            sortMenu.style.display = sortMenu.style.display === 'none' ? 'block' : 'none';
        }

        function sortItems(value) {
            // 여기에 정렬 로직을 추가합니다
            console.log("선택된 정렬 기준:", value);
            // 예: 가격 높은 순 또는 낮은 순으로 정렬하는 코드
        }
    </script>
</head>
<body>

<div id="content_3"> 
    <div id="button_container" onclick="toggleSortMenu()">
        <img src="images/array_white.png" alt="정렬 기능 버튼">
    </div>

    <div id="sortMenu" style="display: none;">
        <select onchange="sortItems(this.value)">
            <option value="high">가격 높은 순</option>
            <option value="low">가격 낮은 순</option>
        </select>
    </div>
</div>

</body>
</html>
