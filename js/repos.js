import {snippets} from "./snippets.js";

var innerContent = document.getElementsByClassName("inner-content")[0]
let repos = [
    {
        id: 1,
        title: "ARZ Assistant",
        desc: "Помощник для Arizona Role Play",
        url: "/reposdata/arzassistant.lua",
    },
    {
        id: 2,
        title: "AFK Tools",
        desc: "Помощник для прокачки аккаунта на Arizona Role Play",
        url: "/reposdata/afktools.lua",
    },
    {
        id: 3,
        title: "VR Chat Remover",
        desc: "Управление випчатом для Arizona Role Play",
        url: "/reposdata/vrcr.lua",
    },
    {
        id: 4,
        title: "Imgui Scoreboard",
        desc: "Новая таблица игроков на MoonImGui",
        url: "/reposdata/imscoreboard.lua",
    },
]

if(innerContent) {
    for (var i = 0; i < repos.length; i++) {
        var reposObj = repos[i]
        var reposStr = `<div class="repos-element" id="repos-${reposObj.id}">
    <div class="info">
        <p class="title">${reposObj.title}</p>
        ${reposObj.desc.replace(/\n/g,"<br>")}
    </div>
    <a class="download" href="${reposObj.url}" download>Скачать</a>
</div>`
        innerContent.innerHTML += reposStr
    }
}