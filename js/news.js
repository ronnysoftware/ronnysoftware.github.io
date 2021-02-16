import {snippets} from "./snippets.js";

var innerContent = document.getElementsByClassName("inner-content")[0]
let news = [
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
    {
        id: 1,
        title: "ronnysoftware website",
        desc: "теперь оффициально доступен сайт <a href=\"https://vk.com/ronnysoftware\" style=\"color: rgb(255, 7, 112); text-decoration: none; font-weight: bold;\">ronnysoftware <i class=\"fas fa-check\" style=\"font-size: 12px; color: rgb(255, 7, 112);\"></i></a> и вы можете спокойно скачать скрипты которые вас интересуют",
    },
]

if(innerContent) {
    for (var i = 0; i < news.length; i++) {
        var newsObj = news[i]
        var newsStr = `<div class="news-element" id="news-${newsObj.id}">
    <p class="title">${newsObj.title}</p>
    ${newsObj.desc.replace(/\n/g,"<br>")}
</div>`
        innerContent.innerHTML += newsStr
    }
}