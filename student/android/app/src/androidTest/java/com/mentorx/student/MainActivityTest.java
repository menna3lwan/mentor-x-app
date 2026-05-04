package com.mentorx.student;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import androidx.test.platform.app.InstrumentationRegistry;
import android.util.Log;
import java.util.Collection;
import java.util.Arrays;
import java.util.Map;
import java.lang.reflect.Method;
import java.lang.reflect.Field;

@RunWith(Parameterized.class)
public class MainActivityTest {
    private static boolean isInitialized = false;

    @Parameters(name = "{0}")
    public static Collection<Object[]> testNames() {
        return Arrays.asList(new Object[][]{
            {"features.robot_nav_test"},
            {"features.robot_stress_test"}
        });
    }

    private final String dartTestGroup;

    public MainActivityTest(String dartTestGroup) {
        this.dartTestGroup = dartTestGroup;
    }

    @Test
    public void runDartTest() {
        Log.i("PATROL_DEBUG", "Execution: Starting group " + dartTestGroup);
        try {
            Object runner = InstrumentationRegistry.getInstrumentation();
            
            synchronized (MainActivityTest.class) {
                if (!isInitialized) {
                    Log.i("PATROL_DEBUG", "Execution: Initializing Patrol (once per run)");
                    
                    // 1. Initialize Patrol (Launch app)
                    try {
                        Method setUpMethod = runner.getClass().getMethod("setUp", Class.class);
                        setUpMethod.invoke(runner, MainActivity.class);
                    } catch (Exception e) {
                        Log.e("PATROL_DEBUG", "Execution: setUp failed", e);
                    }

                    // 2. Wait for Dart side service
                    try {
                        Method waitMethod = runner.getClass().getMethod("waitForPatrolAppService");
                        waitMethod.invoke(runner);
                    } catch (Exception e) {
                        Log.e("PATROL_DEBUG", "Execution: waitForPatrolAppService failed", e);
                    }
                    
                    isInitialized = true;
                }
            }

            // 3. Resolve Full Test Name from Group
            String fullName = dartTestGroup;
            try {
                Method listMethod = runner.getClass().getMethod("listDartTests");
                Object[] tests = (Object[]) listMethod.invoke(runner);
                if (tests != null) {
                    for (Object test : tests) {
                        String testName = (String) test;
                        if (testName.startsWith(dartTestGroup)) {
                            fullName = testName;
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                Log.e("PATROL_DEBUG", "Execution: listDartTests failed", e);
            }

            // 4. CRITICAL HACK: Manually populate skip map
            try {
                Field skipMapField = runner.getClass().getDeclaredField("dartTestCaseSkipMap");
                skipMapField.setAccessible(true);
                Map<String, Boolean> map = (Map<String, Boolean>) skipMapField.get(runner);
                if (map != null) {
                    map.put(fullName, false);
                    Log.i("PATROL_DEBUG", "Execution: Injected skip=false for " + fullName);
                }
            } catch (Exception e) {
                Log.w("PATROL_DEBUG", "Execution: Manual skip map injection failed: " + e.getMessage());
            }

            // 5. Execute the actual test
            Method runMethod = runner.getClass().getMethod("runDartTest", String.class);
            runMethod.invoke(runner, fullName);
            Log.i("PATROL_DEBUG", "Execution: Successfully finished " + fullName);
        } catch (Exception e) {
            Log.e("PATROL_DEBUG", "Execution: FATAL ERROR for " + dartTestGroup, e);
            throw new RuntimeException("Failed to execute Dart test: " + dartTestGroup, e);
        }
    }
}
