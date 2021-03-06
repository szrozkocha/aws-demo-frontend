import {Component, OnInit} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {environment} from "../environments/environment";

interface StatusResponse {
  message: string;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  message: string = "(no message)"

  constructor(private httpClient: HttpClient) {
  }

  ngOnInit(): void {
    this.httpClient.get<StatusResponse>(environment.apiUrl + "/status").subscribe({
      next: response => this.message = response.message,
      error: err => this.message = "Error(status: " + err.status + ", message: " + err.message + ")"
    });
  }
}
