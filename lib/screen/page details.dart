import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/service/detailsApi.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';
import 'package:syriaonline/model/model services.dart';

class Detailes extends StatefulWidget {
  @override
  _DetailesState createState() => _DetailesState();
  Detailes({this.id});
  int id;
}

class _DetailesState extends State<Detailes> {
  ServicesModel servName;
  ServicesModel image;
  ServicesModel description;

  Future<List<ServicesModel>> fdata() async {
    GetInfo name = GetInfo(n: widget.id.toString());
    GetInfo img = GetInfo(n: widget.id.toString());
    GetInfo desc = GetInfo(n: widget.id.toString());

    await name.getserv();
    await img.getserv();
    await desc.getserv();

    ServicesModel n = await name.getserv();
    ServicesModel i = await img.getserv();
    ServicesModel d = await name.getserv();
    servName = n;
    image = i;
    description = d;

    return [servName, image, description];
  }

  var iduser;

  double ratingX = 2.5;
//-------------------------------------get id user----------------------------

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString('account_id');
    });
  }
//-------------------------------------add rate----------------------------

  addrate(context, Map map) async {
    bool result = await postdata(rate, map);
    print(map);
  }

  void initState() {
    super.initState();
    fdata();
    // print(preferences.getString('account_id'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<ServicesModel>>(
            future: fdata(),
            builder: (BuildContext ctx,
                AsyncSnapshot<List<ServicesModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                // ServicesModel n = snapshot.data[0];
                return ListView(
                  children: [
                    //--------------------details service---------------------------------
                    Container(
                      height: 250,
                      child: GridTile(
                        child: Image.network(snapshot.data[1].picture),
                        footer: Container(
                          color: Colors.white70,
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                    child: Text(snapshot.data[0].serviceName)),
                                Expanded(
                                    child: SmoothStarRating(
                                        allowHalfRating: false,
                                        starCount: 5,
                                        rating: 2.5, //from data
                                        size: 20,
                                        isReadOnly: true,
                                        color: Colors.red,
                                        borderColor: Colors.red,
                                        spacing: 0.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: Text(
                      'Rate This Service ',
                      style: kTextBody,
                    )),
                    SizedBox(
                      height: 25,
                    ),
                    //-------------------------------stars rate--------------------------

                    Center(
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            ratingX = v;
                            Map rated = {
                              'rate_from_5': '$ratingX',
                              'service_id': '4',
                              'account_id': iduser.toString(),
                            };
                            print(rated);
                            setState(() {
                              addrate(context, rated);
                            });
                            //for data
                          },
                          starCount: 5,
                          rating: ratingX,
                          size: 40.0,
                          isReadOnly: false,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 0.0),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //-----------------------------descrubtion----------------------------

                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snapshot.data[2].serviceDescription,
                          style: kTextBody,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
