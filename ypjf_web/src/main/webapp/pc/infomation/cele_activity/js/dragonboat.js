var teamInfo = {
        '��֮��' : {
            class : 'd1',
            id : 5
        },
        '�ڷɶ�' : {
            class : 'd2',
            id : 6
        },
        '������' : {
            class : 'd3',
            id : 7
        },
        'Զ����' : {
            class : 'd4',
            id : 8
        }
    },
    activityId = 39,
    dragonBoatInfos = {};

var MAX_DRAGON_BOAT_MOVE_DISTANCE = 150000,
    MAX_DRAGON_BOAT_VIEW_WIDTH = 1200,
    ACTUAL_WIDTH_PERCENT = 63;
CALCULATION_SCALE = MAX_DRAGON_BOAT_VIEW_WIDTH / MAX_DRAGON_BOAT_MOVE_DISTANCE;

function getDistanceInView(distance) {
    return distance * CALCULATION_SCALE;
}

function isLogin() {
    return !!'${pcuser.phone}';
}

function getEncodedCurrentURL() {
    return encodeURIComponent(location.href);
}

function showLoginPrompt() {
    layer.alert('�Բ��𣬵�½��ſ��Բμӻ���Ƿ��¼��', {btn: ['��¼', 'ȡ��']}, function () {
        location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
    }, function () {

    });
}

function getMovePercent(dis) {
    return getDistanceInView(dis) / MAX_DRAGON_BOAT_VIEW_WIDTH
        * ACTUAL_WIDTH_PERCENT;
}

function showBoatView() {
    $.each(teamInfo, function(name, info) {
        var movePercent = getMovePercent(dragonBoatInfos[name]);

        console.log(movePercent);

        $('#img_' + info.id).css('left', function() {
            return (parseFloat($(this)[0].style.left.replace('%', ''))
                + movePercent) + '%';
        }).next().find('img').css('left', function() {
            return (parseFloat($(this)[0].style.left.replace('%', ''))
                + movePercent) + '%';
        }).end().next('img').css('left', function() {
            return (parseFloat($(this)[0].style.left.replace('%', ''))
                + movePercent) + '%';
        }).next().css('left', function() {
            return (parseFloat($(this)[0].style.left.replace('%', ''))
                + movePercent) + '%';
        }).html(dragonBoatInfos[name] + '��');
    });
}

function loadTeams() {
    // ����С���б�
    $.get('/yingpu/pc/activity/201806/dragon_boat/info/json', {
        activityId : activityId
    }, function (data) {
        var infoContainers;
        $.each(data.data || [], function(i, t) {
            infoContainers = $('.' + teamInfo[t.groupName].class + ' span');
            infoContainers.eq(0).html(t.totalAnnualized || 0);
            infoContainers.eq(1).html(t.userAnnualized || 0);
            infoContainers.eq(2).html(t.userNum || 0);
            dragonBoatInfos[t.groupName] = t.moveDistance || 0;
        });

        showBoatView();
    });
}


// ����С��
function join(gId, cb) {
    if (!isLogin()) {
        showLoginPrompt();
        return;
    }

    $.get('/yingpu/pc/activity/201806/dragon_boat/activity_group/join/json', {
        groupId: gId,
        actId : activityId
    }, function (data) {
        if (data.status == 'success') {
            loadTeams();
            cb && cb();
        }
        else {
            layer.msg(data.message);
        }
    });
}

function loadUser() {
    // �����û���Ϣ
    $.get('/yingpu/pc/activity/201806/dragonboat/userinfo/json', {activityId : activityId}, function (data) {
        if (data.status == 'success') {
            var info = data.data;
            if (!$.isEmptyObject(info)) {
                loadTeams();
                $(".zhandui").css({"display":"none" });
            }
        }
        else {
            layer.msg(data.message || '');
        }
    });
}

function praise(gId) {
    $.get('/yingpu/pc/activity/201806/dragon_boat/cheerfor/json', {
        activityId : activityId,
        groupId : gId
    }, function (data) {
        if (data.status == 'success') {
            var movePercent = getMovePercent(data.data);

            $('#img_' + gId).css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).next().find('img').css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).end().next('img').css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).next().css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).html(function() {
                return (parseInt($(this).html().replace('��', '')) + data.data) + '��';
            });
            layer.msg('�����ɹ���');
        }
        else {
            layer.msg(data.message || '');
        }
    });
}

useLoadingShade();
$(".zhandui img").click(function(){
    if (!isLogin()) {
        showLoginPrompt();
        return;
    }

    join(teamInfo[$(this).attr('alt')].id, function() {
        $(".zhandui").css({"display":"none" });
        $(".sction").css({"display":"block"})
    });
});

$('[id^=zan_]').on('click', function() {
    var groupId = $(this).attr('id').substr(-1, 1);
    praise(groupId);
});

loadUser();
