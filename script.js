
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
                        document.getElementById('welcome').textContent = data.welcome;
                        document.getElementById('home-link').textContent = data.home;
                        document.getElementById('cv-link').textContent = data.cv;
                        document.getElementById('footer').textContent = data.footer;
                        document.getElementById('name').textContent = data.name;
                        document.getElementById('role').textContent = data.role;
                        document.getElementById('mission').textContent = data.mission;
                        document.getElementById('education').textContent = data.education;
                        document.getElementById('educationSubtitle').textContent = data.educationSubtitle;
                        document.getElementById('news').textContent = data.news;
                        document.getElementById('video-about').textContent = data.videoAbout;
                    
                        // Traitement de projectSteps
                        const projectStepsElement = document.getElementById('projectSteps');
                        projectStepsElement.innerHTML = '';
                        for (const step of data.projectSteps) {
                            const li = document.createElement('li');
                            li.textContent = step;
                            projectStepsElement.appendChild(li);
                        }
                    
                        // Traitement de projects
                        const projectsElement = document.getElementById('projects');
                        projectsElement.innerHTML = '';
                        for (const project of data.projects) {
                            const projectElement = document.createElement('div');
                            
                            // Création d'une liste pour les types de projets
                            const projectTypeList = document.createElement('ul');
                            const projectTypeItem = document.createElement('li');
                            projectTypeList.appendChild(projectTypeItem);
                            
                            const projectType = document.createElement('p');
                            projectType.textContent = project.type;
                            projectTypeItem.appendChild(projectType); // Ajout du type de projet comme élément de la liste
                            
                            projectElement.appendChild(projectTypeList);
                            
                            // Création d'une sous-liste pour les détails
                            const detailsList = document.createElement('ul');
                            for (const detail of project.details || []) { // Vérification si details existe pour éviter les erreurs
                                const detailItem = document.createElement('li');
                                detailItem.textContent = detail;
                                detailsList.appendChild(detailItem);
                            }
                            projectTypeItem.appendChild(detailsList); // Ajout des détails comme sous-liste du type de projet
                            
                            projectsElement.appendChild(projectElement);
                        }
                    })
                    .catch(error => console.error('Error loading content:', error));
            }

            function changeVideoSubtitlesLanguage(langCode) {
                const langMapping = {
                    'en': 'en',
                    'fr': 'fr-FR',
                    'jp': 'ja'
                };

                var object = document.getElementById('video-youtube');
                var video = document.getElementById('youtube');
                var data = object.data;
                var href = video.href;

                var youtubeLangCode = langMapping[langCode] || 'en';
                href = href.replace(/cc_lang_pref=[a-zA-Z-]{2,5}/, 'cc_lang_pref=' + youtubeLangCode);
                data = data.replace(/cc_lang_pref=[a-zA-Z-]{2,5}/, 'cc_lang_pref=' + youtubeLangCode);
                video.href = href;
                object.data = data;
            }


            const lang = getLanguage();
            sessionStorage.setItem('lang', lang);
            fetchContent(lang);
            changeVideoSubtitlesLanguage(lang);

            document.getElementById('lang-switcher').addEventListener('click', function(event) {
                if (event.target.classList.contains('flag')) {
                    const selectedLang = event.target.getAttribute('about');
                    fetchContent(selectedLang);
                    changeVideoSubtitlesLanguage(selectedLang);
                    window.history.pushState({}, '', `?lang=${selectedLang}`);
                    sessionStorage.setItem('lang', selectedLang);
                }
            });
        });