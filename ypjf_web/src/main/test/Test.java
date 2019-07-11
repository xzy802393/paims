import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.SmartInvestmentProject;
import com.cz.yingpu.system.service.ISmartProjectInvestmentService;

import javax.annotation.Resource;
import java.util.List;

public class Test {
	@Resource
	private ISmartProjectInvestmentService smartProjectInvestmentService;
	@org.junit.Test
	public void method(){
		projecRaisetOnComplete();
	}
	public void projecRaisetOnComplete() {
		List<SmartInvestmentProject> projects = null;

		try {
			projects = smartProjectInvestmentService.queryForList(new Finder(
							"SELECT id FROM t_smart_investment_project WHERE status = 3 AND remainsAmount = 0"),
					SmartInvestmentProject.class);

			if (!projects.isEmpty()) {
				for (SmartInvestmentProject project : projects) {

					project = smartProjectInvestmentService.findById(
							project.getId(), SmartInvestmentProject.class);
					if (project.getStatus() != 4) {
						double[] arr = smartProjectInvestmentService.smartInvestDisperseProject(project);
						if (arr[0] == project.getTotalAmount() && arr[1] == 0.0) {
							project.setStatus(4);
						}
						double dispersedAmount = smartProjectInvestmentService.
								smartInvestDisperse(project);

						project.setDispersedAmount((double) dispersedAmount);
						smartProjectInvestmentService.update(project, true);
					}
				}

				smartProjectInvestmentService.generateDummyDispersedRecord();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}






}
