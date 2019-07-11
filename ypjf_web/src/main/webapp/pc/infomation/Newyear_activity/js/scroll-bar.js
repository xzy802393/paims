		function Scroll(panelId, scrollBarId, scrollBtnId, step){
            var panel = document.getElementById(panelId);
            var scrollBar = document.getElementById(scrollBarId);
            var scrollBtn = document.getElementById(scrollBtnId);
            var scrollBarDownY = 0, scrollTop = 0.0, lastScrollTop = 0, isSlither = false, distance = 0, a = 0.0;
            var val1 = null;
            var wnd = window, doc = document;

            //再此设置滚动条位置大小
            scrollBar.style.height = panel.offsetHeight+"px";

            function slither()
            {
                if(val1 == null){
                    val1 = setInterval(function(){
                        if(isSlither) {
                            isSlither = false;
                            distance = scrollTop - lastScrollTop;
                            a =  distance / 30;
                            lastScrollTop = scrollTop;
                        }

                        if(distance != 0)
                        {
                            scrollTop += distance / 3.0;
                            panel.scrollTop = scrollTop;
                            if(Math.abs(panel.scrollTop - scrollTop) > 0)
                                lastScrollTop = scrollTop = panel.scrollTop;
                            distance -= a;
                            if(Math.abs(distance) < Math.abs(a))
                                distance = a = 0;
                        }
                        else
                        {
                            clearInterval(val1);
                            val1 = null;
                        }
                    }, 30);
                }
            }


            var setBar = function(){
                var scan = panel.getBoundingClientRect().height / panel.scrollHeight;
                if(scan >= 1) {
                    scrollBtn.style.display = "none"
                }
                else{
                    scrollBtn.style.display = "block"
                    scrollBtn.style.height = (scan * 100)+"%";
                    scrollBtn.style.top = (panel.scrollTop/ panel.scrollHeight * 100)+"%";

                }
            }
            setTimeout(function(){setBar();}, 1000);

            panel.onscroll = function(){
                setBar();
            }

            var mouseMove = function(e)
            {
                isSlither = true;
                if(scrollBarDownY > 0)
                    lastScrollTop = scrollTop = panel.scrollTop = (e.clientY-scrollBar.getBoundingClientRect().top - scrollBarDownY) / panel.getBoundingClientRect().height * panel.scrollHeight;
                wnd.getSelection ? wnd.getSelection().removeAllRanges() : doc.selection.empty(); //防止拖动时选中内容
            }

            doc.onmouseup = function(){
                scrollBarDownY = 0;
                doc.onmousemove = null;
            }

            scrollBtn.onmousedown = function(e) {
                scrollBarDownY = e.clientY - scrollBtn.getBoundingClientRect().top;
                doc.onmousemove = mouseMove;
                distance = 0;
            }

            scrollBar.onmousedown = function(e)
            {
                if(e.clientY < scrollBtn.getBoundingClientRect().top || e.clientY > scrollBtn.getBoundingClientRect().bottom) {
                    scrollBarDownY = 1;
                    distance = 0;
                    lastScrollTop = scrollTop = panel.scrollTop = (e.clientY - scrollBar.getBoundingClientRect().top) / panel.getBoundingClientRect().height * panel.scrollHeight;
                }
            }

            scrollBar.onmousewheel = panel.onmousewheel = function(e) {
                /*if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件
                    isSlither = true;
                    //slither();
                    if (e.wheelDelta > 0) { //当滑轮向上滚动时
                        panel.scrollTop -= step;
                        scrollTop -= step;
                    }
                    if (e.wheelDelta < 0) { //当滑轮向下滚动时
                        panel.scrollTop += step;
                        scrollTop += step;
                    }
                } else if (e.detail) {  //Firefox滑轮事件
                    isSlither = true;
                    //slither();
                    if (e.detail> 0) { //当滑轮向上滚动时
                        panel.scrollTop  -= step;
                        scrollTop -= step;
                    }
                    if (e.detail< 0) { //当滑轮向下滚动时
                        panel.scrollTop  += step;
                        scrollTop += step;
                    }
                }
            }
            e.stopPropagation();
            e.preventDefault();*/
            }
        }
        