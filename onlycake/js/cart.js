document.addEventListener("DOMContentLoaded", function () {
    // 체크박스 변경 시 선택한 가격 업데이트 함수
    function updateSelectedPrice() {
        let selectedTotalPrice = 0;
        let selectedTotalQuantity = 0;

        document.querySelectorAll(".cart-item").forEach(function (item) {
            let checkbox = item.querySelector(".checkbox");
            if (checkbox.checked) {
                let itemPrice = parseInt(item.querySelector(".item-total").innerText.replace(/[^0-9]/g, ""), 10);
                let itemQuantity = parseInt(item.querySelector("input[name='ctQty']").value, 10);
                selectedTotalPrice += itemPrice;
                selectedTotalQuantity += itemQuantity;
            }
        });

        // 배송비: 선택된 상품이 있으면 3000원
        let shippingFee = selectedTotalPrice > 0 ? 3000 : 0;
        let finalTotalPrice = selectedTotalPrice + shippingFee;

        document.getElementById("selectedTotalPrice").innerText = selectedTotalPrice.toLocaleString() + " 원";
        document.getElementById("finalTotalPrice").innerText = finalTotalPrice.toLocaleString() + " 원";
        document.getElementById("selectedTotalQuantity").innerText = selectedTotalQuantity + " 개";
    }

    // 초기 업데이트
    document.querySelectorAll(".checkbox").forEach(function (checkbox) {
        checkbox.addEventListener("change", updateSelectedPrice);
    });
    updateSelectedPrice();

    // 결제하기 버튼에서 호출할 전역 함수 등록
    window.goToPayment = function () {
        console.log("결제 버튼 클릭됨");
        const selectedCheckboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
        console.log("선택된 체크박스 개수:", selectedCheckboxes.length);

        if (selectedCheckboxes.length === 0) {
            alert("결제할 상품을 선택해주세요.");
            return;
        }

        let selectedItems = [];
        let selectedTotalPrice = 0;
        let computedTotalsArray = [];

        selectedCheckboxes.forEach((checkbox) => {
            const ctNo = checkbox.value;
            selectedItems.push(ctNo);
            const priceElement = document.getElementById("itemTotal_" + ctNo);
            if (priceElement) {
                // 예: "31,000 원" 에서 숫자만 추출
                let raw = priceElement.innerText.replace(/[^0-9]/g, "");
                let computed = parseInt(raw, 10);
                selectedTotalPrice += computed;
                // "ctNo:computed" 형태로 저장 (예: "abc123:31000")
                computedTotalsArray.push(ctNo + ":" + computed);
            } else {
                console.error("itemTotal 요소를 찾을 수 없음:", ctNo);
            }
        });

        const deliveryFee = 3000;
        const finalTotalPrice = selectedTotalPrice + deliveryFee;

        // computedTotalsArray를 콤마로 구분한 문자열로 변환
        const computedTotalsStr = computedTotalsArray.join(",");

        console.log("총 상품 금액:", selectedTotalPrice);
        console.log("총 결제 금액:", finalTotalPrice);
        console.log("computedTotals:", computedTotalsStr);

        // URL 파라미터에 selectedItems, selectedTotalPrice, finalTotalPrice, computedTotals 추가
        const url = `PayBank.jsp?selectedItems=${encodeURIComponent(selectedItems.join(","))}` +
                    `&selectedTotalPrice=${selectedTotalPrice}` +
                    `&finalTotalPrice=${finalTotalPrice}` +
                    `&computedTotals=${encodeURIComponent(computedTotalsStr)}`;
        console.log("이동할 URL:", url);
        window.location.href = url;
    };
});
