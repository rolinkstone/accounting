<?php

use App\Http\Controllers\UserActivityController;
use App\Http\Controllers\v1\KodeIndukController;
use App\Http\Controllers\v1\DashboardController;
use App\Http\Controllers\v1\KodeAkunController;
use App\Http\Controllers\v1\KunciTransaksiController;
use App\Http\Controllers\v1\MemorialController;
use App\Http\Controllers\v1\TransaksiBankController;
use App\Http\Controllers\v1\TransaksiKasController;
use App\Http\Controllers\v1\UsersController;
use App\Http\Controllers\v1\CustomerController;
use App\Http\Controllers\v1\SupplierController;
use App\Http\Controllers\v1\GeneralLedger\BukuBesarController;
use App\Http\Controllers\v1\GeneralLedger\NeracaSaldoController;
use App\Http\Controllers\v1\GeneralLedger\LabaRugiController;
use App\Models\KunciTransaksi;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('lupa-password-email', [UsersController::class, 'forgotPasswordEmail'])->name('lupa_password_email');
Route::put('lupa-password-email', [UsersController::class, 'forgotPasswordEmailProcess'])->name('lupa_password_email_process');
Route::get('lupa-password/{email}', [UsersController::class, 'forgotPassword'])->name('lupa_password_page');
Route::post('lupa-password', [UsersController::class, 'forgotPasswordProcess'])->name('lupa_password');

Route::get('/', function () {
    return view('auth.login');
});

// Route::get('/dashboard', function () {
//     return view('dashboard');
// })->middleware(['auth'])->name('dashboard');
Route::middleware(['auth'])->group(function () {
    // dashboard
    // action([DashboardController::class, 'index']);
    Route::get('/dashboard',[DashboardController::class,'index'])->name('dashboard');
    // users trash
    Route::get('/user/trash',[UsersController::class,'trashUser'])->name('user.trash');
    Route::get('/user/restore/{id}',[UsersController::class,'restoreUser'])->name('user.restore');
    Route::delete('/user/{id}/hapus',[UsersController::class,'hapusPermanen'])->name('user.hapusPermanen');
    // Users Management
    Route::resource('/user', UsersController::class);

    // Supplier Management
    Route::get('/supplier/trash',[SupplierController::class,'trashSupplier'])->name('supplier.trash');
    Route::get('/supplier/restore/{id}',[SupplierController::class,'restoreSupplier'])->name('supplier.restore');
    Route::delete('/supplier/{id}/hapus',[SupplierController::class,'hapusPermanen'])->name('supplier.hapusPermanen');
    Route::resource('/supplier', SupplierController::class);

    // Customer Management
    Route::get('/customer/trash',[CustomerController::class,'trashCustomer'])->name('customer.trash');
    Route::get('/customer/restore/{id}',[CustomerController::class,'restoreCustomer'])->name('customer.restore');
    Route::delete('/customer/{id}/hapus',[CustomerController::class,'hapusPermanen'])->name('customer.hapusPermanen');
    Route::resource('/customer', CustomerController::class);

    // change password
    Route::get('/change-password', [UsersController::class, 'changePassword'])->name('change_password');
    Route::put('/change-password/{id}', [UsersController::class, 'updatePassword'])->name('update_password');
    // master akuntasi
    Route::prefix('master-akuntasi')->group(function () {
        // Kode Induk trash
        Route::get('/kode-induk/trash',[KodeIndukController::class,'trashKodeInduk'])->name('kodeInduk.trash');
        Route::get('/kode-induk/restore/{id}',[KodeIndukController::class,'restoreKodeInduk'])->name('kodeInduk.restore');
        Route::delete('/kode-induk/{id}/hapus',[KodeIndukController::class,'hapusPermanen'])->name('kodeInduk.hapusPermanen');
        // Kode Induk
        Route::resource('/kode-induk',KodeIndukController::class);
        // Kode Akun trash
        Route::get('/kode-akun/trash',[KodeAkunController::class,'trashKodeAkun'])->name('kodeAkun.trash');
        Route::get('/kode-akun/restore/{id}',[KodeAkunController::class,'restoreKodeAkun'])->name('kodeAkun.restore');
        Route::delete('/kode-akun/{id}/hapus',[KodeAkunController::class,'hapusPermanen'])->name('kodeAkun.hapusPermanen');
        // Kode Akun
        Route::resource('/kode-akun',KodeAkunController::class);
        // KunciTransaksi
        Route::resource('/kunci-transaksi',KunciTransaksiController::class);
    });
    // Kas Transaksi
    Route::prefix('kas')->group(function () {
        Route::get('/kas-transaksi/addDetailKasTransaksi',[TransaksiKasController::class,'DetailKasTransaksi']);
        Route::get('/kas-transaksi/addEditDetailKasTransaksi',[TransaksiKasController::class,'addEditDetailKasTransaksi']);
        // Kode Transaksi Kas
        Route::get('/kas-transaksi/trash',[TransaksiKasController::class,'trashTransaksiKas'])->name('transaksiKas.trash');
        Route::get('/kas-transaksi/restore/{id}',[TransaksiKasController::class,'restoretransaksiKas'])->name('transaksiKas.restore');
        Route::delete('/kas-transaksi/{id}/hapus',[TransaksiKasController::class,'hapusPermanen'])->name('transaksiKas.hapusPermanen');
        Route::resource('/kas-transaksi',TransaksiKasController::class);
        Route::prefix('laporan-kas')->group(function () {
            Route::get('/',[TransaksiKasController::class,'reportKas']);
            Route::get('result',[TransaksiKasController::class,'getReport'])->name('laporan-kas');
            Route::get('print',[TransaksiKasController::class,'printReport'])->name('print-kas');
        });
        // Route::resource('/laporan-kas',TransaksiKasController::class);
    });

    // Bank Transaksi
    Route::prefix('bank')->group(function () {
        Route::get('/bank-transaksi/addDetailbankTransaksi',[TransaksiBankController::class,'DetailbankTransaksi']);
        Route::get('/bank-transaksi/addEditDetailBankTransaksi',[TransaksiBankController::class,'addEditDetailBankTransaksi']);
        // Kode Transaksi Bank
        Route::get('/bank-transaksi/trash',[TransaksiBankController::class,'trashTransaksiBank'])->name('transaksiBank.trash');
        Route::get('/bank-transaksi/restore/{id}',[TransaksiBankController::class,'restoretransaksiBank'])->name('transaksiBank.restore');
        Route::delete('/bank-transaksi/{id}/hapus',[TransaksiBankController::class,'hapusPermanen'])->name('transaksiBank.hapusPermanen');
        Route::resource('/bank-transaksi',TransaksiBankController::class);
        Route::prefix('laporan-bank')->group(function () {
            Route::get('/',[TransaksiBankController::class,'reportBank']);
            Route::get('result',[TransaksiBankController::class,'getReport'])->name('laporan-bank');
            Route::get('print',[TransaksiBankController::class,'printReport'])->name('print-bank');
        });
    });

    // Memorial
    Route::prefix('memorial')->group(function () {
        Route::get('/memorial/addDetailMemorial',[MemorialController::class,'DetailMemorial']);
        Route::get('/memorial/addEditDetailMemorial',[MemorialController::class,'addEditDetailMemorial']);
        // Kode Memorial
        Route::get('/memorial/trash',[MemorialController::class,'trashTransaksiMemorial'])->name('transaksiMemorial.trash');
        Route::get('/memorial/restore/{id}',[MemorialController::class,'restoretransaksiMemorial'])->name('transaksiMemorial.restore');
        Route::delete('/memorial/{id}/hapus',[MemorialController::class,'hapusPermanen'])->name('transaksiMemorial.hapusPermanen');
        Route::resource('/memorial', MemorialController::class);
        Route::prefix('laporan-memorial')->group(function () {
            Route::get('/',[MemorialController::class,'reportMemorial']);
            Route::get('result',[MemorialController::class,'getReport'])->name('laporan-memorial');
            Route::get('print',[MemorialController::class,'printReport'])->name('print-memorial');
        });
    });

    // general ledger
    Route::group(['prefix' => 'general-ledger'], function () {
        Route::get('buku-besar', [BukuBesarController::class, 'index']);
        Route::post('buku-besar', [BukuBesarController::class, 'index']);
        Route::post('buku-besar/export', [BukuBesarController::class, 'export']);

        Route::get('neraca-saldo', [NeracaSaldoController::class, 'index']);
        Route::post('neraca-saldo', [NeracaSaldoController::class, 'index']);
        Route::post('neraca-saldo/export', [NeracaSaldoController::class, 'export']);

        Route::get('laba-rugi', [LabaRugiController::class, 'index']);
        Route::post('laba-rugi', [LabaRugiController::class, 'index']);
        Route::post('laba-rugi/export', [LabaRugiController::class, 'export']);

    });

    // User Activity
    Route::resource('user-activity',UserActivityController::class);


});

require __DIR__.'/auth.php';
