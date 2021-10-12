const pay = () => {
  // PAY.JPテスト公開鍵（webpacker.rbを用いて環境変数を呼び出し）
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); 
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    // フォームの情報を取得
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order[card_number]"),
      cvc: formData.get("order[card_cvc]"),
      exp_month: formData.get("order[card_exp_month]"),
      exp_year: `20${formData.get("order[card_exp_year]")}`,
    };
    // カードの情報を送信し、トークン化されたものがレスポンスとして帰ってくる
    // pay.jsが提供するPayjp.createToken(card, callback)というオブジェクトとメソッドを使用
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        // レスポンスの値を代入
        const token = response.id;
        // トークンの値をフォームに含める
        const renderDom = document.getElementById("charge-form");
        // パラメータ作成。キー名：値＝token:token(Payjpからのレスポンス)
        // const tokenObj = `<input value=${token} name='token'>`;
        // トークンの値を非表示にする
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        // HTMLにtokenObj要素を追加（renderDomの内部の最後の子要素の後に追加）
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        debugger;
      }
      // クレジットカードの情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);