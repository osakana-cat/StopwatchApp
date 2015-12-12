//
//  ViewController.m
//  StopwatchApp
//
//  Created by さき on 2015/12/12.
//  Copyright © 2015年 saki.yokota. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    // 時刻を表示するためのラベルインスタンスを格納するための変数
    UILabel *timeLabel;
    
    // じゃんけん画像を表示するためのイメージビューインスタンスを格納するための変数
    UIImageView *aImageView;
    
    // タイマーインスタンスを格納するための変数
    NSTimer *timer;

    // カウント用の変数
    NSInteger countNumber;
    
    //　時間カウント用の変数
    NSInteger timeCountNumber;
    
    NSInteger minute;
    NSInteger second;
    
    // スタートボタンの作成
    UIButton *startbutton;
    
    //一時停止の記録用
    NSInteger time;
    
    //一時停止かスタートかの判断
    BOOL timeflg;
    
}

@end

@implementation ViewController


-(void)stop{
    if (timer != nil){
        //タイマーを止める命令
        [timer invalidate];
        time=timeCountNumber;
    }
}


-(void)reset:(id)sender{
    
    if (timer != nil){
        //タイマーを止める命令
        [timer invalidate];
        timer = nil;
        timeCountNumber=0;
        timeLabel.text = @"00:00";
        timeflg = FALSE;
    }
   
}

-(void)tick:(NSTimer*)timer{
    
    
    timeCountNumber++;
    
    
    countNumber++;
    if (countNumber == 1) {
        aImageView.image = [UIImage imageNamed:@"gu.png"];
    } else if (countNumber == 2) {
        aImageView.image = [UIImage imageNamed:@"choki.png"];
    } else if (countNumber == 3) {
        aImageView.image = [UIImage imageNamed:@"pa.png"];
        countNumber = 0;
    }
    
    [self setElapsedTime];
    
}

-(void)start:(id)sender{
    
    if (timeflg == TRUE) {//一時停止時
        
        [self stop];
        
        [startbutton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
        
        timeCountNumber = time;
        
        timeflg = FALSE;
        
        
    }else{//スタート or 再開
        
        timeflg=TRUE;
        
        // タイマーインスタンスを作成
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        
        [startbutton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];

    }
    
    
}



-(void)setElapsedTime{
    
    minute = timeCountNumber/60;
    
    second = timeCountNumber%60;
    
    NSString *elapsedStrings =[NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    //ラベルに現在時刻を表示
    [timeLabel setText:elapsedStrings];
}


-(void)setupParts{
    // 背景画像を設定
    aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 120)];
    aImageView.center = CGPointMake(160, 180);
    
    // 画像を設定
    aImageView.image = [UIImage imageNamed:@"gu.png"];
    
    // イメージビューを画面に貼付ける
    [self.view addSubview:aImageView];
    
    
    
    // ラベルを作成
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    
    // ラベルの位置を中心で設定
    timeLabel.center = CGPointMake(160, 310);
    
    // ラベルに表示するフォントと文字サイズの設定
    timeLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:48];
    
    // ラベルに表示する文字を設定
    timeLabel.text = @"00:00";
    
    // ラベルの文字寄せを設定
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    // ラベルの背景色を透明に設定
    timeLabel.backgroundColor = [UIColor clearColor];
    
    // ラベルを画面に貼付ける
    [self.view addSubview:timeLabel];
    
    
    // スタートボタンの作成
    startbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // ボタンの位置を設定
    startbutton.frame = CGRectMake(0, 0, 90, 90);
    startbutton.center = CGPointMake(110, 400);
    
    // ボタンの画像を設定
    if(timeflg==FALSE){
        
        [startbutton setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
        
        
    }

    
    // ボタンを押したときに呼ばれるメソッドを設定
    [startbutton addTarget:self action:@selector(start:)
     forControlEvents:UIControlEventTouchUpInside];
    
    // スタートボタンを画面に貼付ける
    [self.view addSubview:startbutton];
    
    
    
    //リセットボタン作成
    UIButton *resetbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // ボタンの位置を設定
    resetbutton.frame = CGRectMake(0, 0, 90, 90);
    resetbutton.center = CGPointMake(210, 400);

    // ボタンの画像を設定
    [resetbutton setImage:[UIImage imageNamed:@"reset.png"] forState:UIControlStateNormal];

    // リセットボタンを押したときに呼ばれるメソッドを設定
    [resetbutton addTarget:self action:@selector(reset:)
     forControlEvents:UIControlEventTouchUpInside];

    // リセットボタンを画面に貼付ける
    [self.view addSubview:resetbutton];

    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ラベルとイメージビューを作成するメソッドを呼び出す
    [self setupParts];
    
    
    //カウント用の変数に0を代入
    countNumber = 0;
    timeCountNumber = 0;
    minute = 0;
    second = 0;
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
