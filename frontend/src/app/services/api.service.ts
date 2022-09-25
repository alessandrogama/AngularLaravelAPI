import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders  } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  noAuthHeader = { headers: new HttpHeaders({ NoAuth: 'True' }) };
  constructor(
    private http: HttpClient,
  ) { }

  public getHello(): Observable<any> {
    return this.http.get(environment.apiHost + '/hello');
  }

  public getDate(): Observable<any> {
    return this.http.get(environment.apiHost + '/getdate');
  }
  public sendInput(text: Request): Observable<any> {
    return this.http.post(environment.apiHost + '/getinput',text,this.noAuthHeader);
  }


}
