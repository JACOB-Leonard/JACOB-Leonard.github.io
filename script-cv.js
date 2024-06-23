        document.addEventListener("DOMContentLoaded", function() {
    
            function getQueryParam(param) {
                const urlParams = new URLSearchParams(window.location.search);
                return urlParams.get(param);
            }
    
            function getLanguage() {
                let lang = getQueryParam('lang');
                if (lang) return lang;
    
                lang = sessionStorage.getItem('lang');
                if (lang) return lang;
    
                lang = navigator.language.split('-')[0];
                if (['en', 'fr', 'jp'].includes(lang)) return lang;
    
                return 'en';
            }

            function fetchContent(lang) {
                fetch(`./${lang}/content.json`)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('title').textContent = data.title;
                        document.getElementById('home-link').textContent = data.home;
                        document.getElementById('cv-link').textContent = data.cv;
                    })
                .catch(error => console.error('Error loading content:', error));
            }           
    
            const lang = getLanguage();
            fetchContent(lang);
            loadAndTransformContent(lang);
            sessionStorage.setItem('lang', lang);
            // URL du fichier XML et XSL
    
            function transformXMLtoHTML(xmlString, xslString) {
                const parser = new DOMParser();
                const xmlDoc = parser.parseFromString(xmlString, "text/xml");
                const xslDoc = parser.parseFromString(xslString, "text/xml");
    
                const xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xslDoc);
    
                const resultFragment = xsltProcessor.transformToFragment(xmlDoc, document);
    
                const tempDiv = document.createElement('div');
                tempDiv.appendChild(resultFragment);
    
                return tempDiv.innerHTML;
            }
    
            function loadAndTransformContent(lang) {
                const xmlFile = `xml/cv_${lang}.xml`;
                const xslFile = `xsl/cv_${lang}.xsl`;

                fetch(xmlFile)
                    .then(response => response.text())
                    .then(xmlString => {
                        fetch(xslFile)
                            .then(response => response.text())
                            .then(xslString => {
                                const transformedHTML = transformXMLtoHTML(xmlString, xslString);
                                document.getElementById('content').innerHTML = transformedHTML;
                            })
                            .catch(error => console.error('Error loading XSL file:', error));
                    })
                    .catch(error => console.error('Error loading XML file:', error));
            }
        
            document.getElementById('lang-switcher').addEventListener('click', function(event) {
                    if (event.target.classList.contains('flag')) {
                        const selectedLang = event.target.getAttribute('about');
                        window.history.pushState({}, '', `?lang=${selectedLang}`);
                        sessionStorage.setItem('lang', selectedLang);
                        fetchContent(selectedLang);
                        loadAndTransformContent(selectedLang);
                    }
            });
        });