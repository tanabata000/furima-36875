// 販売価格の項目を自動計算するメソッド
function sell_price_content (){
  // HTML要素取得
  // 価格フォーム部分（対象id:item-price）
  const ItemPrice = document.getElementById("item-price")
  // item-priceを取得できた時のみ処理をするように設定
  if(ItemPrice){
  
  // 販売手数料の表示部分（対象id:add-tax-price）
  const AddTaxPrice = document.getElementById("add-tax-price")
  // 販売利益の表示部分（対象id:profit）
  const Profit = document.getElementById("profit");
  // 販売手数料率
  const TaxRate = 0.1
  
  // キーボード入力によりイベント発火
  ItemPrice.addEventListener("input", () => {
    // 価格から計算される値
    // 価格の入力値をItemValに代入
    let ItemPriceVal = ItemPrice.value; 
    // 販売手数料を計算（価格＊販売手数料率）。小数点以下切り捨て
    let AddTaxPriceVal = Math.floor(ItemPriceVal * TaxRate)
    // 販売利益を計算（価格＊販売手数料）。小数点以下切り捨て
    let ProfitVal = Math.floor(ItemPriceVal - AddTaxPriceVal)
   
    // HTML要素の書き換え（価格の入力値により自動表示）
    // 販売手数料表示。書き換え対象：id:add-tax-price。カンマ表記あり
    AddTaxPrice.innerHTML = AddTaxPriceVal.toLocaleString(); 
    //販売利益表示。書き換え対象：id:profit。カンマ表記あり
    Profit.innerHTML = ProfitVal.toLocaleString();
  });
  }
};
// ページが開いた後にcountメソッド実行
window.addEventListener('load', sell_price_content);