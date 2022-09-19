package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.quartz.service.JobConfigService;
import cloud.flystar.solon.quartz.service.QuartzJobHandler;
import cloud.flystar.solon.quartz.service.entity.JobConfig;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;

/**
 * 定时任务
 */
@RestController
@RequestMapping("/job")
public class JobController {

    @Autowired
    private QuartzJobHandler quartzJobHandler;

    @Autowired
    private JobConfigService jobConfigService;


    //创建&启动
    @GetMapping("/startSimpleJob")
    public String startSimpleJob() throws SchedulerException, ClassNotFoundException, ParseException {
        JobConfig jobConfig = jobConfigService.getById(1L);
        quartzJobHandler.deleteJob(jobConfig);
        quartzJobHandler.addJob(jobConfig);
        return "startJob Success!";
    }

    /**
     * 创建cron Job
     * @return
     */
    @RequestMapping("/createCronJob")
    @ResponseBody
    public String createJob() {

        return "创建成功";
    }

    /**
     * 暂停job
     * @return
     */
    @RequestMapping(value = {"/pauseJob/{jobName}","/pauseJob/{jobName}/{jobGroup}"})
    @ResponseBody
    public String pauseJob(@PathVariable("jobName") String jobName,@PathVariable(required = false) String jobGroup) {

        return "暂停成功";
    }

    @RequestMapping(value = {"/resume/{jobName}","/resume/{jobName}/{jobGroup}"})
    @ResponseBody
    public String resume(@PathVariable("jobName") String jobName,@PathVariable(required = false) String jobGroup) {

        return "启动成功";
    }

    @RequestMapping(value = {"/delete/{jobName}","/delete/{jobName}/{jobGroup}"})
    public String delete(@PathVariable("jobName") String jobName,@PathVariable(required = false) String jobGroup) {

        return "删除成功";
    }

    @RequestMapping(value = {"/check/{jobName}","/check/{jobName}/{jobGroup}"})
    public String check(@PathVariable("jobName") String jobName,@PathVariable(required = false) String jobGroup) {
        return "检查成功";

    }

    @RequestMapping(value = {"/status/{jobName}","/status/{jobName}/{jobGroup}"})
    @ResponseBody
    public String status(@PathVariable("jobName") String jobName,@PathVariable(required = false) String jobGroup) {

        return "获取状态成功";
    }


}
