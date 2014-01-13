part of restlib.data_test;

userAgentTests(){
  test("parse with valid user agents", (){
    String test = "Mozilla/5.0 (Linux; U; Android 2.1-update1; en-us; SGH-T959 Build/ECLAIR) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17";
    expect(USER_AGENT.parse(test).value.toString(), equals(test));   
  });
}