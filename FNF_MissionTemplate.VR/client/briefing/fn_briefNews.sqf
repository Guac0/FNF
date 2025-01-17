// https://community.bistudio.com/wiki/BIS_fnc_showAANArticle
phx_article_fnc_NewYear2022 = {
  [
    [
      ["title","Happy New Year 2022!"],
      ["meta",["Friday Night Fight Staff",[2022,1,1,22,30],"EST"]],
      ["textbold","A review of 2021 in the FNF World"],
      ["image",[getMissionPath "description\images\article_bg1.paa","Composite: BLUFOR and INDFOR forces evacuating casualties"]],
      // ["box",["\a3\Missions_F_Orange\Data\Img\Faction_IDAP_overview_CA.paa","Doctors hate him! Stop sucking at Arma 3 with this one cool trick!"]],
      ["text","<t font='PuristaMedium' size='0.7'>Happy New Year from the Friday Night Fight Staff! As our year comes to an end we thought we’d recollect with you all what a year we had. FNF was present for 50 weeks this year with over 300 hundred missions played. We also reached over 2000 members in discord this year, with some 100 new members joining every month. We hope to see more impact at our events and in our discord!<br/><br/>In an effort to be more community-facing, the FNF Feedback Form was created in January. The form alongside the subsequent release of our community polls gave us valuable insights into what our player base was looking for early this year. In April we introduced our Community Channels 'to allow the communities that attend FNF to properly introduce themselves, and to provide a space for coordination of events outside of FNF.' We were also proud to finally launch the FNF website in September, finally accomplishing a multi-year goal: <a href='https://www.fridaynightfight.org/'>https://www.fridaynightfight.org/</a><br/><br/>The back half of our staff were deep in the trenches churning out new framework updates and quality of life improvements steadily throughout the year. We saw our framework go from version 2.0.0 to 3.0.3 over 21 update releases. These releases featured our major ORBAT change, more MAT customization for mission makers, additional options for CEs and weapon choices, additional mission maker utilities, and the creation of a custom building map marking system.<br/><br/>Our players saw the quality of life adjustments with the inclusion of the player reporting system, the redesigned map diary to provide as much information as possible, the discord round status message, and the integration of the OCAP2 (AAR) system at <a href='http://aar.fridaynightfight.org/'>http://aar.fridaynightfight.org</a> which is now used by many to debrief and coordinate improvements on an individual community level. There were simply too many changes to list them all!<br/><br/>We were able to promote and run several special events this year. In February, the first-ever FNF Titans tournament premiered, and running for two seasons, we saw Scandi Recon emerge victorious in Season 1 and the 2nd Marine Raider Battalion achieve final victory in Season 2.<br/><br/>March saw the introduction of FNF Karts! We had over 30 people sign up. I wonder… Who won that?<br/><br/>Tuesday Night Tanks made its return in May, showcased by a flawless trailer by Ceb.<br/><br/>FNF WWII made its return in June once again showcased by an amazing Ceb trailer. We took a bit of a break for the rest of the summer and into the fall to focus on the event internally.<br/><br/>We came out swinging in late November with FNF v OFCRA and our major success was the FNF Vietnam Event.<br/><br/>And finally, we closed out our year with our first ever S.O.O.N event on December 26th. We hope to bring you even more special events in 2022 and really build off of our success with FNF Vietnam!<br/><br/>This year didn’t come without missteps or tragedy. With Space Engineers and Minecraft, we tried to host off-night gaming for our community. Unfortunately, these were short-lived and we decided to shelve the project. We attempted to roll out a monthly newsletter, but again we found this wasn’t the best option for our community. Our Staff Talks sessions started out jam-packed but quickly dwindled to nothing.<br/><br/>Our first attempt at the FNF video contest flopped, but we brought it back with the Screenshot contest where [FLG] Alban, Mazz38, and [82ndDK] Lone provided some absolutely sick screenshots. It's safe to say we didn’t get everything, but these hiccups really helped us throughout the year.<br/><br/>And in September, one of FNF's long-standing communities Arma Addicts saw a longtime member pass, highlighting the often overlooked existence of those suffering from mental health even on the internet.<br/><br/>The end of 2021 has brought another major change for the FNF Staff. We’ve decided to trim down some 50% of our current numbers and in doing so we’ve had to say goodbye to some prevalent, active, and longstanding members of our staff. We’re entering 2022 with a lean/mean staff team that’s looking to crank out some even greater updates and events throughout the year.<br/><br/>WOW, It’s incredible to think that all of this just happened in 2021, we’re excited to see what 2022 will bring us and look forward to everyone joining us. We’ll see you at our hangover event on January 1st and we’ll be rolling out the first Friday Night Fight of 2022 on the 7th. We know you’ll be around because you all aren’t square. See you then.</t>"],
      // ["textlocked",["In FNF's future iterations, you'll see:<br/><br/>  - More Vietnam content<br/>  - Bigger guns<br/>  - More supplies </br>  - More karts","Click here to subscribe"]],
      ["author",[getMissionPath "description\images\fnf.paa","Our diverse staff come from all over the world offering varied expertise to provide you with the best experience possible here at the Friday Night Fight."]]
      // ["draft",[nil, nil]]
    ],
    call BIS_fnc_displayMission,
    true
  ] call BIS_fnc_showAANArticle;
};


PHX_Diary_News = player createDiarySubject ["PHX_Diary_News", "News", "\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa"];

player createDiaryRecord [
  "PHX_Diary_News",
  [
    "Trailers",
    [
      "<executeClose expression=""openYoutubeVideo 'watch?v=sZnAiEfqLO0'"">Vietnam Trailer</execute>",
      "<executeClose expression=""openYoutubeVideo 'watch?v=REpD_Y7SsQk'"">WWII Trailer</execute>",
      "<executeClose expression=""openYoutubeVideo 'watch?v=ADVe2fzKsJU'"">FNF Titans Trailer</execute>",
      "<executeClose expression=""openYoutubeVideo 'watch?v=E-cQRWSxH80'"">FNF Promo</execute>"
    ] joinString "<br/>"
  ]
];

player createDiaryRecord [
  "PHX_Diary_News",
  [
    "Articles",
    [
      "<executeClose expression='[] call phx_article_fnc_NewYear2022'>Happy New Year 2022</execute>"
    ] joinString "<br/>"
  ]
];

