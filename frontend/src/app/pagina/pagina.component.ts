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

  constructor(
    private apiService: ApiService
  ) { }

  ngOnInit(): void {
    this.apiService.getHello().pipe(
      catchError((err) => {
        this.apiGreeting = 'Falha na comunicação com o servidor.';
        return [];
      })
    ).subscribe((response) => {
      if (response) {
        this.apiGreeting = response.mensagem;
      }
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
    this.apiService.sendInput(form.value).pipe(
      catchError((err) => {
        this.text = 'Falha na comunicação com o servidor.';
        return [];
      })
    ).subscribe((response) => {
      if (response) {
        this.text = response;
      }
    });
  }

}
