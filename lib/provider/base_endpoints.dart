String getBaseURL() {
  return "http://0.0.0.0:80";
}

Map<String, String> headers() {
  String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQVRJU0hBWSBKQUlOIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xRcm5nQnVWQ0t1VmhfZ2JwY25VMXBvdExEWmFYVXVObXlQTTV6S0JfalB3PXM5Ni1jIiwidXNlcl9pZCI6IllDRHVnb1hNd3dWZWFxczJTVk5EVzJZaGRoQTIiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXVkIjoic29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXV0aF90aW1lIjoxNzA3MjQ1NTY4LCJzdWIiOiJZQ0R1Z29YTXd3VmVhcXMyU1ZORFcyWWhkaEEyIiwiaWF0IjoxNzA3MjQ1NTY4LCJleHAiOjE3MDcyNDkxNjgsImVtYWlsIjoiYXRpc2hheWoyMjAyQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA2Nzk4MDM2ODY1NzQ4MTAyNzI4Il0sImVtYWlsIjpbImF0aXNoYXlqMjIwMkBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJjdXN0b20ifX0.M6JL5m3IzeDTV-eFR1vJTpMSl4H-SqHehpno0gzKzx3KBSAi5uhItWkB0J3kJYLjEFbceRmD8VQUwhR-4cwYirEEuXZvrRdIesdDoY_47iSuNkR4MhERGXjfppTP6ZeVVA3d--cMSG68qpv-lYTGELZl-JPTNKWS745FwlFztbb_-J2TckqQIEqc5RYxFf_WVqHAYMzcjs6lF1ada7jFGZP6vEe9l6Err-e8Io-yRk8VJOtcAqaUOpoFFcttpfMxPmWyg1D5yP-kWFPLahmOoT6E62axysMqJtfMNtQMIMQ0s2v1A0CXFr2265tSDbpKNB-yHLCo7jIcu2ItXOIlfw";
  return {
    "Authorization": "Bearer $idToken",
    'Content-Type': 'application/json'
  };
}