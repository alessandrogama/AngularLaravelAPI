import { Component, OnInit } from '@angular/core';

import { catchError } from 'rxjs/operators';

import { ApiService } from '../services/api.service';

import {NgForm} from '@angular/forms';


@Component({
  selector: 'app-pagina',
  templateUrl: './pagina.component.html',
  styleUrls: ['./pagina.component.scss']
})
export class PaginaComponent implements OnInit {

  public apiGreeting = '';
  public apiDate = '';
  public text = '';
  public loading = false;



  constructor(
    private apiService: ApiService
  ) { }

  ngOnInit(): void {
    this.loading = true;
    this.apiService.getHello().pipe(
      catchError((err) => {
        this.loading = false;
        this.apiGreeting = 'Falha na comunicação com o servidor.';
        return [];
      })
    ).subscribe((response) => {
      if (response) {
        this.apiGreeting = response.mensagem;
      }
      this.loading = false;
    });
    this.apiService.getDate().pipe(
      catchError((err) => {
        this.apiDate = 'Falha na comunicação com o servidor.';
        return [];
      })
    ).subscribe((response) => {
      if (response) {
        this.apiDate = response;
      }
    });
  }
  onSubmit(form: NgForm) {
    this.loading = true;
    this.apiService.sendInput(form.value).pipe(
      catchError((err) => {
        this.loading = false;
        this.text = 'Falha na comunicação com o servidor.';
        return [];
      })
    ).subscribe((response) => {
      if (response) {
        this.text = response;
      }
      this.loading = false;
    });
  }

}
