// 販売価格の項目を自動計算するメソッド
function sell_price_content (){
  // HTML要素取得
  // 価格フォーム部分（対象id:item-price）
  const ItemPrice = document.getElementById("item-price")
  if(ItemPrice){

  
  // 販売手数料の表示部分（対象id:add-tax-price）
  const AddTaxPrice = document.getElementById("add-tax-price")
  // 販売利益の表示部分（対象id:profit）
  const Profit = document.getElementById("profit");
  // 販売手数料のパーセンテージ（数値のみ入力）
  const TaxRate=10
  
  // キーボード入力によりイベント発火
  ItemPrice.addEventListener("input", () => {
    // 価格の入力値をItemValに代入
    let ItemPriceVal = ItemPrice.value; 
    //HTML要素の書き換え（対象id:add-tax-price）。小数点以下切り捨て（入力値/販売手数料レート）:カンマ表記あり
    AddTaxPrice.innerHTML = Math.floor(ItemPriceVal / TaxRate).toLocaleString(); 
    // 販売手数料の値（カンマ除外）をAddTaxPriceValに代入
    let AddTaxPriceVal = parseFloat(AddTaxPrice.innerHTML)
    //HTML要素の書き換え（対象id:profit"）。小数点以下切り捨て（価格-販売手数料）:カンマ表記あり
    Profit.innerHTML = Math.floor(ItemPriceVal - AddTaxPriceVal).toLocaleString();
    // 販売利益の値（カンマ除外）をProfitValに代入
    let ProfitVal = Profit.innerHTML
  });
  }
};
// ページが開いた後にcountメソッド実行
window.addEventListener('load', sell_price_content);