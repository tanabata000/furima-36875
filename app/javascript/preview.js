document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('item-images')){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {
       // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length
      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);

      // ファイル選択ボタンを生成
      // input要素をJavaScript側で生成
      const inputHTML = document.createElement('input');
      // input要素に属性を指定
      inputHTML.setAttribute('id', `item_images_${imageElementNum}`)
      inputHTML.setAttribute('name', 'item[images][]')
      inputHTML.setAttribute('type', 'file')
      
      // 画像サイズ調整
      blobImage.width=300;
      blobImage.height=200;
      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      imageElement.appendChild(inputHTML);
      ImageList.appendChild(imageElement);
    };

    // document.getElementById('item-images').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      // const imageContent = document.querySelector('img');
      // if (imageContent){
      //   imageContent.remove();
      // }
      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob)
      
      // const file = e.target.files[0];
      // const blob = window.URL.createObjectURL(file);

      // createImageHTML(blob);
    });
  }
});