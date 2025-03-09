document.addEventListener('DOMContentLoaded', function() {
    // FAQのトグル機能
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', () => {
            // 現在のアイテムの状態を切り替え
            item.classList.toggle('active');
            
            // トグルアイコンの更新
            const toggleIcon = item.querySelector('.toggle-icon');
            if (item.classList.contains('active')) {
                toggleIcon.textContent = '−';
            } else {
                toggleIcon.textContent = '+';
            }
            
            // 他のアイテムを閉じる
            faqItems.forEach(otherItem => {
                if (otherItem !== item && otherItem.classList.contains('active')) {
                    otherItem.classList.remove('active');
                    otherItem.querySelector('.toggle-icon').textContent = '+';
                }
            });
        });
    });
    
    // 最初のFAQアイテムを開いた状態にする
    if (faqItems.length > 0) {
        faqItems[0].classList.add('active');
        faqItems[0].querySelector('.toggle-icon').textContent = '−';
    }
    
    // スムーズスクロール
    const navLinks = document.querySelectorAll('nav a, .footer-links a');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // リンクが#で始まり、かつ同じページ内のリンクの場合のみ処理
            if (this.getAttribute('href').startsWith('#')) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);
                
                if (targetElement) {
                    // ヘッダーの高さを考慮したスクロール位置の計算
                    const headerHeight = document.querySelector('header').offsetHeight;
                    const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - headerHeight;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            }
        });
    });
    
    // お問い合わせフォームの送信処理
    const contactForm = document.getElementById('inquiry-form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // フォームデータの取得
            const formData = new FormData(this);
            const formValues = {};
            
            for (let [key, value] of formData.entries()) {
                formValues[key] = value;
            }
            
            // 通常はここでAPIにデータを送信するが、デモなのでアラートを表示
            alert('お問い合わせありがとうございます。\n内容を確認次第、担当者よりご連絡いたします。');
            
            // フォームをリセット
            this.reset();
        });
    }
    
    // スクロール時のヘッダーエフェクト
    const header = document.querySelector('header');
    let lastScrollTop = 0;
    
    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > lastScrollTop && scrollTop > 100) {
            // 下にスクロール
            header.style.transform = 'translateY(-100%)';
        } else {
            // 上にスクロール
            header.style.transform = 'translateY(0)';
        }
        
        lastScrollTop = scrollTop;
    });
    
    // デモ動画のプレースホルダークリック処理
    const videoPlaceholder = document.querySelector('.video-placeholder');
    
    if (videoPlaceholder) {
        videoPlaceholder.addEventListener('click', function() {
            // 実際のデモ環境では、ここで動画再生処理を実装
            alert('デモ動画は準備中です。実際の導入環境では、ここに製品のデモ動画が表示されます。');
        });
    }
});