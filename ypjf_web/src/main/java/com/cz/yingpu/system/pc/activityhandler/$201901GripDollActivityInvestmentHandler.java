package com.cz.yingpu.system.pc.activityhandler;

import com.cz.yingpu.frame.util.CalculationUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import javax.management.RuntimeErrorException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 19年1月抓娃娃活动资格计算
 */
public class $201901GripDollActivityInvestmentHandler extends $201812xxDrawActivityInvestmentHandler {

    public $201901GripDollActivityInvestmentHandler(int actId) {
        super(actId);
    }

    /**
     * 计算用户投资可获得的参与活动资格
     */
    @Override
    public void handle(AppUser au, UserProject up, IBaseSpringrainService service) {
        super.handle(au, up, service);
    }
}
